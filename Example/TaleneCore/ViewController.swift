//
//  ViewController.swift
//  TaleneCore
//
//  Created by w.frankthamel@gmail.com on 05/19/2020.
//  Copyright (c) 2020 w.frankthamel@gmail.com. All rights reserved.
//

import UIKit
import TaleneCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // register observer
        App.managers.notification.localNotificationManager.addObserver(forNotification: AppNotifications.Core.userAuthenticatedSuccess, inClass: self, withTarget: #selector(testSelector))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("Viewcontroller deinit.")
        App.managers.notification.localNotificationManager.removeObserver(inClass: self)
    }

    @IBAction func showInfoAlert(_ sender: Any) {
         //let alertModel = InfoAlertModel(descriptions: [TCConstants.description : TCSay.Alerts.sign_in_verification_failed] , containerController: self)
         let alertModel = CustomAlertModel(type: .custom(AppAlerts.createSignInWithEmailAlert), params: [TCConstants.isFirebase: true], containerController: self)
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
    }

    @objc func testSelector(_ notification: NSNotification) {
        print("Notification called with info \(notification.userInfo ?? [:])")
    }
}
