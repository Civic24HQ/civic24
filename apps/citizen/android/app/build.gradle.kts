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

// Release signing: anyone can test a release build; only a store release needs the real key.
// - The release build type is signed with the upload key when key.properties is usable, otherwise with the
//   debug key (with a warning), so contributors and CI can try a release. This covers every flavor,
//   including flavors added later. Never distribute a debug-signed build.
// - A production release (or any task that includes one, such as `assemble`, `bundle` or `assembleRelease`)
//   without a usable key.properties stops with a message, so a store build is never debug-signed by
//   accident. To test the production flavor locally, opt in with
//   `--android-project-arg debugSignRelease=true` (Flutter) or `-PdebugSignRelease=true` (Gradle).
// - The stop looks at the release tasks Gradle resolved, not at the command line, and not at signing
//   task names: without a keystore Gradle creates no signing task and builds an unsigned app.
// - Android Studio's "Generate Signed App Bundle" passes its own credentials (android.injected.signing.*),
//   so nothing is checked then.
// - Not checked for Gradle's configuration cache: the task graph hook below reads the project, and the
//   cache is not enabled. Test this if it ever is.
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

gradle.taskGraph.whenReady {
    val releaseTaskPattern = Regex("^(assemble|bundle|install|package|sign)[A-Za-z]*Release(Bundle)?$")
    val releaseTasks = allTasks.filter { it.project == project && releaseTaskPattern.matches(it.name) }
    if (signingProblem != null && releaseTasks.isNotEmpty()) {
        if (releaseTasks.any { it.name.contains("Production", ignoreCase = true) } && !debugSignRelease) {
            throw GradleException(
                "Production release builds must be signed with the upload key, but $signingProblem\n$signingHelp " +
                    "To try a production release locally without it (never to distribute), add " +
                    "--android-project-arg debugSignRelease=true. Debug builds and other flavors' " +
                    "release builds do not need any of this.",
            )
        }
        logger.warn("WARNING: signing this release with the DEBUG key because $signingProblem\n$signingHelp Do not distribute this build.")
    }
}

android {
    namespace = "co.civic24.citizen"
    // 37 because permission_handler 13 compiles against it. targetSdk stays at 36.
    compileSdk = 37
    // Same as Flutter 3.47's own value (flutter.ndkVersion); pinned here so a Flutter upgrade cannot change it silently.
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
        // Pinned (Flutter's value is also 36): Google Play sets target API deadlines, so raise it on purpose.
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName(if (signingProblem == null) "release" else "debug")
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
                    providers.gradleProperty("crashlyticsMappingUpload").map { it.toBoolean() }.getOrElse(true)
            }
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Civic24"
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".stg"
            manifestPlaceholders["appName"] = "Civic24 STG"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders["appName"] = "Civic24 DEV"
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
