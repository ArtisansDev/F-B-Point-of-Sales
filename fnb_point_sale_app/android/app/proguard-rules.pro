# Keep all Flutter and Kotlin classes
-keep class io.flutter.** { *; }
-keep class androidx.** { *; }
-keep class com.google.** { *; }
-keep class kotlin.** { *; }

# Keep all classes that use reflection
-keepattributes *Annotation*
-keep class * { @Keep *; }

# Avoid stripping Parcelable classes
-keep class * implements android.os.Parcelable { *; }

# Keep classes for Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Prevent obfuscation of JSON models
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
