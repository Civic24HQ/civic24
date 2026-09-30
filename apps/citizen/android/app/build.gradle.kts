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
val signingTaskPattern = Regex("(assemble|bundle|package|install|sign)\\w*Release", RegexOption.IGNORE_CASE)
val signingTasks = gradle.startParameter.taskNames.filter { signingTaskPattern.containsMatchIn(it) }
val ideSuppliesSigning = providers.gradleProperty("android.injected.signing.store.file").isPresent
val debugSignRelease = providers.gradleProperty("debugSignRelease").map { it.toBoolean() }.getOrElse(false)
var useDebugSigningForRelease = false

if (signingTasks.isNotEmpty() && !ideSuppliesSigning) {
    val requiredKeys = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
    val missing = requiredKeys.filter { keystoreProperties.getProperty(it).isNullOrBlank() }
    val problem =
        when {
            !keystorePropertiesFile.exists() -> "${keystorePropertiesFile.path} does not exist."
            missing.isNotEmpty() -> "${keystorePropertiesFile.name} is missing: ${missing.joinToString(", ")}."
            !file(keystoreProperties.getProperty("storeFile")).exists() ->
                "the keystore \"${keystoreProperties.getProperty("storeFile")}\" does not exist " +
                    "(the path is relative to android/app)."
            else -> null
        }
    if (problem != null) {
        val includesProduction =
            signingTasks.any { !it.contains("development", ignoreCase = true) && !it.contains("staging", ignoreCase = true) }
        val help = "Copy android/key.properties.example to android/key.properties and fill it in."
        if (includesProduction && !debugSignRelease) {
            throw GradleException(
                "Production release builds must be signed with the upload key, but $problem\n$help " +
                    "To try a production release locally without it (never to distribute), add " +
                    "--android-project-arg debugSignRelease=true. Debug builds and development or staging " +
                    "release builds do not need any of this.",
            )
        }
        useDebugSigningForRelease = true
        logger.warn("WARNING: signing this release with the DEBUG key because $problem\n$help Do not distribute this build.")
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
            signingConfig = signingConfigs.getByName(if (useDebugSigningForRelease) "debug" else "release")
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
