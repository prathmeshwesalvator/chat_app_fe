# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# --- ADD RULES FOR YOUR APP MODELS HERE ---
# If your app uses JSON serialization (like freezed or json_serializable),
# you MUST keep your data model classes so R8 doesn't remove or rename them.

# Example:
# -keep class com.example.chat_app_fe.models.** { *; }

# --- FIXES FOR GOOGLE PLAY CORE ERRORS ---
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }

# Prevents R8 from warning about missing classes in play core
-dontwarn com.google.android.play.core.**
# ------------------------------------------