##Steps for Compiling
1. `cordova plugin ls` Ensure all plugins are already installed based on the documentation for the repository.

2. Cordova 5.0+ requires `cordova-plugin-whitelist`. Refer to configuration data for whitelist [here](https://cordova.apache.org/docs/en/4.0.0/guide_appdev_whitelist_index.md.html) and some applications may need to be upgraded when built.

3. Perform a `cordova build ios` or `cordova build android --release`.

    - On **android**, the last lines of the build message will have the path of the APK output.

    - On **iOS**, close xCode (if open) before building and reopen xCode by clicking on the [APP_NAME].xcodeproj file in `/platforms/iOS/`

4. After building, use xCode or adb commands to install the APK/IPA on the device.

####[Signing for Production - Android](http://ionicframework.com/docs/guide/publishing.html)
####[iOS Pushing to Production](http://codewithchris.com/submit-your-app-to-the-app-store/)
####[Checklist for iOS/Android](http://www.dummies.com/how-to/content/app-store-submission-checklist.html)

## List of Common Items Checklist
1. Icons and Splashscreen
2. App Title, Description
3. Screenshots
4. Version Number
5. Ensure the following files are up to date in the repository: package.json, bower.json, config.xml, Makefile
6. Create Pull Request to Release repository.

## Deploying an Upgrade - Android
You will need the keystore and password that was used to sign the previous version of the app. Please request from @DrDanPrice or @peggylind.