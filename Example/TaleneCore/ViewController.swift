//
//  ViewController.swift
//  TaleneCore
//
//  Created by w.frankthamel@gmail.com on 05/19/2020.
//  Copyright (c) 2020 w.frankthamel@gmail.com. All rights reserved.
//

import UIKit
import TaleneCore

class ViewController: TCViewController {

    let configs: [String: NSObject] = ["isSaleActive": "false" as NSObject]

    override func viewDidLoad() {
        super.viewDidLoad()

        // register observer
        App.managers.notification.localNotificationManager.addObserver(forNotification: AppNotifications.Core.userAuthenticatedSuccess, inClass: self, withTarget: #selector(testSelector))

        // set remote configs
        //App.settings.configs.rc.setDefaults(fromDictionary: configs)
        App.settings.configs.rc.setDefaults(fromPlist: TCConstants.firebaseRemoteConfigs)
        TCRun.afterDelay(seconds: 20) {
            print("isSaleActive: \(App.settings.configs.rc.remoteConfig.configValue(forKey: "isSaleActive").stringValue ?? "")")
            print("salePercentage: \(App.settings.configs.rc.remoteConfig.configValue(forKey: "salePercentage").stringValue ?? "")")
        }

    }

    deinit {
        print("Viewcontroller deinit.")
        App.managers.notification.localNotificationManager.removeObserver(inClass: self)
    }

    @IBAction func showInfoAlert(_ sender: Any) {
         //let alertModel = InfoAlertModel(descriptions: [TCConstants.description : TCSay.Alerts.sign_in_verification_failed] , containerController: self)
        //let alertModel = CustomAlertModel(type: .custom(AppAlerts.createSignInWithEmailAlert), params: [TCConstants.isFirebase: true], containerController: self)


        let model = AdsShareModel(title: "Title of the push message.", message: "This is a test message. This is a test message. This is a test message. This is a test message.", hashTags: ["#Talene"], openUrl: "https://www.google.com/", image: nil)
        let alertModel = CustomAlertModel(type: .custom(AppAlerts.createTCAdsAlert), params: [TCConstants.model: model], containerController: self)
        
        App.managers.alert.showAlert(model: alertModel)

        //App.managers.message.showMessageView(BuyAppCard.self)
    }

    @IBAction func showErrorAlert(_ sender: Any) {
        //let alertModel = FalierAlertModel(descriptions: ["description" :"This is a Test message."] , containerController: self)
        //App.managers.alert.showAlert(model: alertModel)
        let messegeModel = MessageModel(title: "Error Messege!", subTitle: "This is s sample error messege.", type: .info)
        App.managers.message.showMessage(model: messegeModel)
    }

    @IBAction func showSuccessAlert(_ sender: Any) {
        let alertModel = SuccessAlertModel(descriptions: ["description" :"This is a Test message."] , containerController: self)
        App.managers.alert.showAlert(model: alertModel)


        // schedule local notifications
//        let localNotificationModel1 = LocalNotificationModel(title: "Test Local push 1", subtitle: nil, body: "Teat Local Push body.", repeatableDays: [.saturday], hour: 18, minute: 50, year: nil, isActive: true)
//        App.managers.notification.localPushNotificationManager.scheduleTrigger(localNotificationModel1)
//
//        let localNotificationModel2 = LocalNotificationModel(title: "Test Local push 2", subtitle: nil, body: "Teat Local Push body.", repeatableDays: [.sunday], hour: 18, minute: 55, year: nil, isActive: true)
//        App.managers.notification.localPushNotificationManager.scheduleTrigger(localNotificationModel2)
//
//        let localNotificationModel3 = LocalNotificationModel(title: "Test Local push 3", subtitle: nil, body: "Teat Local Push body.", repeatableDays: [.saturday], hour: 18, minute: 59, year: nil, isActive: true)
//        App.managers.notification.localPushNotificationManager.scheduleTrigger(localNotificationModel3)


        App.managers.notification.localPushNotificationManager.listScheduledNotifications { models in
            guard let models = models else { return }
            models.forEach { (model) in
                print("Local notifications: \(model.id) - Title: \(model.title)")
            }
        }

       // App.managers.notification.localPushNotificationManager.removeAllPendingNotifications()

    }

    @objc func testSelector(_ notification: NSNotification) {
        print("Notification called with info \(notification.userInfo ?? [:])")
    }
}


