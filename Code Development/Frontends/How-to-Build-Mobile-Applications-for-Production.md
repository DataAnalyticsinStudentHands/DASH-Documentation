##Steps for Compiling
1. Make sure all plugins are already installed based on the documentation for the repository.
    - `cordova plugin ls`
2. Cordova 5.0+ requires `cordova-plugin-whitelist`. Refer to configuration data for whitelist [here](https://cordova.apache.org/docs/en/4.0.0/guide_appdev_whitelist_index.md.html) and some applications may need to be upgraded when built.
3. Perform a `cordova build ios` or `cordova build android` (`cordova run android` will install directly on device). On **android**, the last lines of the build message will have the path of the APK output. On **iOS**, close xCode (if open) before building and reopen xCode by clicking on the [APP_NAME].xcodeproj file in `/platforms/iOS/`
4. After building, use xCode or adb commands to install the APK/IPA on the device.

####[Signing for Production - Android](http://ionicframework.com/docs/guide/publishing.html)
####[iOS Pushing to Production](http://codewithchris.com/submit-your-app-to-the-app-store/)
####[Checklist for iOS/Android](http://www.dummies.com/how-to/content/app-store-submission-checklist.html)