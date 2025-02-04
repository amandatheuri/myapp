# Preserve all annotated classes and methods
-keep class androidx.** { *; }

# Keep Flutter classes
-keep class io.flutter.** { *; }

# Prevent obfuscation for model classes
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep entry points
-keep public class * extends android.app.Application
-keep public class * extends android.app.Activity
