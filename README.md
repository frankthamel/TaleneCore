# TaleneCore

[![CI Status](https://img.shields.io/travis/w.frankthamel@gmail.com/TaleneCore.svg?style=flat)](https://travis-ci.org/w.frankthamel@gmail.com/TaleneCore)
[![Version](https://img.shields.io/cocoapods/v/TaleneCore.svg?style=flat)](https://cocoapods.org/pods/TaleneCore)
[![License](https://img.shields.io/cocoapods/l/TaleneCore.svg?style=flat)](https://cocoapods.org/pods/TaleneCore)
[![Platform](https://img.shields.io/cocoapods/p/TaleneCore.svg?style=flat)](https://cocoapods.org/pods/TaleneCore)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TaleneCore is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TaleneCore'
```

## Setup TaleneCore

1. Add pod library

```ruby
	pod 'TaleneCore', :git => 'https://frankthamel@bitbucket.org/frankthamel/talenecore.git', :tag => '1.0.0'
```

2. Call “configureTaleneCore” inside the AppDelegate.
3. Add AppDelegate extension

```swift
	extension AppDelegate {

		private func configureTaleneCore(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
			configureTaleneCoreApp(inType: self, application: application, didFinishLaunchingWithOptions: launchOptions)
		}

		func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
		}

		func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
						 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
			App.managers.notification.remoteNotificationManager.showRemoteMessage(userInfo)
			completionHandler(UIBackgroundFetchResult.newData)
		}

		func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
			App.managers.notification.remoteNotificationManager.registerForRemoteNotificationsWithDeviceToken(token: deviceToken)
		}

		func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
			App.managers.logger.error(message: "Failed to register for notifications: \(error.localizedDescription)")
		}

	}

```

4. Set up a new Firebase project and add the GoogleServiceInfo.plist file to the app root.

5. Set up a Google AdMob account and link admob to Firebase.

6. Add AdMob key to info.plist
```GADApplicationIdentifier = key```

7. Copy color codes from Assets.xcassets to new Asset file

8. Copy configs files form settings folder.
```
	Copy: 
	* FirebaseRemoteConfigs
	* Translations
	* Keys.swift
	* Keys.plist
	* Urls.swift
	* Urls.plist
	* LocalConfigs.swift
	* LocalConfigs.plist
```
9. Copy REVERSED_CLIENT_ID from googleServiceInfo.plist to url schemes

10. Copy Facebook scheme as fb32322323 to Url schemes

11. Copy these to App info.plist
```
	FacebookAppID: 123456789
	FacebookDisplayName: AppName
	GADApplicationIdentifier: ca-aasasasas
	
	LSApplicationQueriesSchemes Array
	fbapi, fb-messenger-api, fbauth2, fbshareextension, twitter, twitterauth, fb-messenger-share-api
```
12. In app capabilities enable push notifications
13. In app capabilities - Background modes, enable Background fetch and remote notifications
14. Copy credits.py to App directory and add the run script to generate credits.plist

```ruby
	./credits.py -s "${PODS_ROOT}" -o "$SRCROOT/PPT/Credits.plist"
```

15. Add the created credits.plist file to App.

## TaleneCore  Architecture Diagram 




## Author

w.frankthamel@gmail.com

## License

TaleneCore is available under the MIT license. See the LICENSE file for more info.
