# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# OkHttp / Okio (used by plugins)
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# Keep annotations
-keepattributes *Annotation*

# Keep source file names and line numbers for stack traces (Sentry)
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
