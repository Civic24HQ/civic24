import com.google.firebase.crashlytics.buildtools.gradle.CrashlyticsExtension
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // Automatic network request monitoring for Firebase Performance.
    id("com.google.firebase.firebase-perf")
}

// Release signing values come from android/key.properties (gitignored; see key.properties.example).
// -PkeyProperties=<path> points at another file, for example one that CI decodes from a secret.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file(providers.gradleProperty("keyProperties").getOrElse("key.properties"))
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

// Release signing rules. Anyone can test a release build; only a store release needs the real key.
// - Development and staging release builds without a usable key.properties are signed with the debug
//   key and print a warning, so contributors and CI can try a release build.
// - Production (and any build that includes it) without a usable key.properties stops with a message,
//   so a store release is never debug-signed by accident. To test the production flavor locally, opt in:
//   `--android-project-arg debugSignRelease=true` (Flutter) or `-PdebugSignRelease=true` (Gradle).
// - Never distribute a debug-signed build.
// - Android Studio's "Generate Signed App Bundle" passes its own credentials
//   (android.injected.signing.*); nothing is checked then.
// The rules are applied per flavor, and the stop looks at the release tasks Gradle actually resolved
// (`assemble<Flavor>Release`, `bundle<Flavor>Release`, ...), so aggregate tasks such as `assemble` or
// `bundle` cannot bypass them. (Signing task names are not used: with no keystore Gradle creates none
// and builds an unsigned production app.)
val ideSuppliesSigning = providers.gradleProperty("android.injected.signing.store.file").isPresent
val debugSignRelease = providers.gradleProperty("debugSignRelease").map { it.toBoolean() }.getOrElse(false)
val requiredKeys = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
val missingKeys = requiredKeys.filter { keystoreProperties.getProperty(it).isNullOrBlank() }
val signingProblem: String? =
    when {
        ideSuppliesSigning -> null
        !keystorePropertiesFile.exists() -> "${keystorePropertiesFile.path} does not exist."
        missingKeys.isNotEmpty() -> "${keystorePropertiesFile.name} is missing: ${missingKeys.joinToString(", ")}."
        !file(keystoreProperties.getProperty("storeFile")).exists() ->
            "the keystore \"${keystoreProperties.getProperty("storeFile")}\" does not exist " +
                "(the path is relative to android/app)."
        else -> null
    }
val signingHelp = "Copy android/key.properties.example to android/key.properties and fill it in."
// Which flavors are signed with the debug key when there is no usable key.properties.
val debugSignedFlavors = if (signingProblem == null) emptySet() else setOf("development", "staging") +
    (if (debugSignRelease) setOf("production") else emptySet())

gradle.taskGraph.whenReady {
    val releaseTaskPattern = Regex("^(assemble|bundle|install|package|sign)[A-Za-z]*Release(Bundle)?$")
    val releaseTasks = allTasks.filter { it.project == project && releaseTaskPattern.matches(it.name) }
    if (signingProblem != null && releaseTasks.isNotEmpty()) {
        val flavors = debugSignedFlavors.filter { flavor -> releaseTasks.any { it.name.contains(flavor, ignoreCase = true) } }
        if (releaseTasks.any { it.name.contains("Production", ignoreCase = true) } && "production" !in debugSignedFlavors) {
            throw GradleException(
                "Production release builds must be signed with the upload key, but $signingProblem\n$signingHelp " +
                    "To try a production release locally without it (never to distribute), add " +
                    "--android-project-arg debugSignRelease=true. Debug builds and development or staging " +
                    "release builds do not need any of this.",
            )
        }
        if (flavors.isNotEmpty()) {
            logger.warn("WARNING: signing the ${flavors.joinToString(", ")} release with the DEBUG key because $signingProblem\n$signingHelp Do not distribute this build.")
        }
    }
}

android {
    namespace = "co.civic24.citizen"
    // 37 because permission_handler 13 compiles against it. targetSdk stays at 36.
    compileSdk = 37
    ndkVersion = "28.2.13676358"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    defaultConfig {
        applicationId = "co.civic24.citizen"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // No signingConfig here: it is set per flavor below (release or debug, see the rules above).
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            // Release builds upload the R8 mapping file to the flavor's Firebase project.
            // Pass `--android-project-arg crashlyticsMappingUpload=false` (Flutter) or
            // `-PcrashlyticsMappingUpload=false` (Gradle) to build locally without uploading.
            configure<CrashlyticsExtension> {
                mappingFileUploadEnabled =
                    (project.findProperty("crashlyticsMappingUpload") as String?)?.toBoolean() ?: true
            }
        }
    }

    flavorDimensions += "default"

    productFlavors {
        // The debug build type keeps its own debug signing; these apply to release builds.
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Civic24"
            signingConfig = signingConfigs.getByName(if ("production" in debugSignedFlavors) "debug" else "release")
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".stg"
            manifestPlaceholders["appName"] = "Civic24 STG"
            signingConfig = signingConfigs.getByName(if ("staging" in debugSignedFlavors) "debug" else "release")
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders["appName"] = "Civic24 DEV"
            signingConfig = signingConfigs.getByName(if ("development" in debugSignedFlavors) "debug" else "release")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.19.0"))
    implementation("com.google.firebase:firebase-analytics")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
