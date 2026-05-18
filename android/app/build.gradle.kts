plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.anime_administration"

    //compileSdkのバージョンを上げる．35以上を推奨，最新は36らしい
    //↓変更ここから
    //compileSdk = flutter.compileSdkVersion
    compileSdk = 36
    //↑変更ここまで
    ndkVersion = flutter.ndkVersion

    //Javaのバージョンを11から17に変更する
    //↓変更ここから
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
    //↑変更ここまで

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.anime_administration"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        //targetSdkが34以下だと最新機種で警告が出る可能性があるみたい，35以上にする．最新は36らしくて，36にする．
        //↓変更ここから
        //targetSdk = flutter.targetSdkVersion
        targetSdk = 36
        //↑変更ここまで
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        //minSdkを設定し，Isarを使えるようにする，21以上がいいらしい
        //↓追記ここから
        minSdk = flutter.minSdkVersion
        //↑追記ここまで
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
