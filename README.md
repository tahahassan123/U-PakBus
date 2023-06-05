# pakistanbusapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.






if you want to run and reploy this application as a developer , so you must have (android phone with android version >5):

1. android studio flamigo version 2022.2.1 patch2
2. flutter sdk 3.10.0
3. dart sdk > 3   , we have build it on dart 3.0.3
4. clone the repository
5. open android folder module separately in new window(android studio)
6. wait until android studio configures the initials
7. goto file-->project structure-->set
   android gradle plugin version=8.0.1
   gradle version=8.0
   click apply and ok and wait for android studio to complete all the downloads
8. goto setting-->build,execution,deployment-->gradle jdk set it jbr-1 java jet brains runtime 17.0.6 ( if you dont have this download it )
   click apply and ok and wait for all the downloadings to be completed
9. goto app's build.gradle and set targetsdk version to 33 and minskdversion to 21 , sync gradle files again
10. download kotlin version=1.7.0
10. click on save all and close android module
11. in flutter project module , goto pubspec.yaml and run pub get
12. goto file in flutter project module and select api 33 in project sdk
13. conncect your phone , your phone must have developer options enables and usb debugging on
14. run the app.


if you want to use this app as a normal user like as we download applications from playstore and just start using it 
so,

connect your phone to our pc and we will run project on your app then ,
it will install the .apk file in your phone directly in around 10 minutes without doing above 14 steps,
then you will use this app as a normal user
