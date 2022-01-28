# evry_sim_in_phone
this plugin return all sims cards on the phon

A new Flutter plugin.

## Getting Started
first you need to add the folowing to your pubspec.yaml
```yaml
evry_sim_in_phone:
      git:
        url: https://github.com/mohamedmv/evry_sim_in_phone.git
        ref: master
```

change the minSDK in your build.gradle to 22
```gradle
        minSdkVersion 22
```
this package need phone permition to handel that we recommend to use permission_handler:
      https://pub.dev/packages?q=permission_handler

add the folowing line to your AndroidManifest.xml just before </manifest>
```Xml
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />
```
first you need to import permition handler and evry_sim_in_phone
 ```dart
 import import 'package:permission_handler/permission_handler.dart';
 import 'package:evry_sim_in_phone/evry_sim_in_phone.dart';
 ```
   first you need to ask for permition
```dart
 PermissionStatus state = await Permission.phone.status;
    if (!state.isGranted) {
       await Permission.phone.request().isGranted;
    }
```
now run the method getAllSims() to get every sims in the phone
```dart
List<String> s = await  EvrySimInPhone.getAllSims()
```

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

