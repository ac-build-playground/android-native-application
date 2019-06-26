plugins {
    id("com.android.application")
    kotlin("android")
    kotlin("android.extensions")
}

android {
    compileSdkVersion(28)
    defaultConfig {
        applicationId = "androidnative.evkhramk.com.android_native_application"
        minSdkVersion(15)
        targetSdkVersion(28)
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "android.support.test.runner.AndroidJUnitRunner"
    }
    buildTypes {
        getByName("release") {
            isShrinkResources = true
            isMinifyEnabled = true
            isUseProguard = true
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
        getByName("debug") {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
        //create("test") {
        //    isMinifyEnabled = false
        //    proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        //}
    }

    flavorDimensions("implementation")

    productFlavors {
        create("free") {
            setDimension("implementation")
            applicationId = "androidnative.evkhramk.com.android_native_application_free"
        }
        create("paid") {
            setDimension("implementation")
            applicationId = "androidnative.evkhramk.com.android_native_application_paid"
        }
        /*create("internal") {
            setDimension("implementation")
            applicationId = "androidnative.evkhramk.com.android_native_application_internal"
        }*/
    }
}

dependencies {
    implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("*.jar"))))
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.3.11")
    implementation("com.android.support:appcompat-v7:28.0.0")
    implementation("com.android.support.constraint:constraint-layout:1.1.3")
    testImplementation("junit:junit:4.12")
    androidTestImplementation("com.android.support.test:runner:1.0.2")
    androidTestImplementation("com.android.support.test.espresso:espresso-core:3.0.2")
}
