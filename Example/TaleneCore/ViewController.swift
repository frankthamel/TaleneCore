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

    var dbRefreshToken: DbRefreshToken?

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

            App.managers.connection.showReachableMesage()
        }

        setAndLoadBannerAds()

        /// load video ad
        App.services.firebaseService.firebaseAdsService.videoAdsService.loadVideoAd()

        view.backgroundColor = App.settings.theme.backgroundColor

        dbRefreshToken = App.store.db.getRealm()?.observe({ (notif, r) in
            print("reload data!")
        })


        let date = Date()
        var date2: Date?

        TCRun.afterDelay(seconds: 55) {
            date2 = Date()
            print(date2! - date)
        }


    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dbRefreshToken?.invalidate()
    }

    deinit {
        print("Viewcontroller deinit.")
        App.managers.notification.localNotificationManager.removeObserver(inClass: self)
    }

    @IBAction func showInfoAlert(_ sender: Any) {
         //let alertModel = InfoAlertModel(descriptions: [TCConstants.description : TCSay.Alerts.sign_in_verification_failed] , containerController: self)
        let alertModel = CustomAlertModel(type: .custom(AppAlerts.createSignInWithEmailAlert), params: [TCConstants.isFirebase: true], containerController: self)


        let model = AdsShareModel(title: "Title of the push message.", message: "This is a test message. This is a test message. This is a test message. This is a test message.", hashTags: ["#Talene"], openUrl: "https://www.google.com/", image: nil)
        //let alertModel = CustomAlertModel(type: .custom(AppAlerts.createTCAdsAlert), params: [TCConstants.model: model], containerController: self)
        
        App.managers.alert.showAlert(model: alertModel)

        //App.managers.message.showMessageView(BuyAppCard.self)
    }

    @IBAction func showErrorAlert(_ sender: Any) {
        //let alertModel = FalierAlertModel(descriptions: ["description" :"This is a Test message."] , containerController: self)
        //App.managers.alert.showAlert(model: alertModel)



        if App.managers.connection.isReachable() {
            let messegeModel = MessageModel(title: "😀", subTitle: "Have internet connection.", type: .success, presentationContext: .statusBar)
            App.managers.message.showMessage(model: messegeModel)
        } else {
            let messegeModel = MessageModel(title: "Error", subTitle: "No internet connection.", type: .error, duration: .seconds(seconds: TimeInterval(App.settings.configs.lc.messageDisplayTime ?? 2)))
            App.managers.message.showMessage(model: messegeModel)
        }

        // save data to realm db
        //let obj = User()
//        let obj: User? = App.store.db.object(forId: "B4C6792D-BA69-4FB1-B5AD-2103C71E9D56")
//
//        let isSaved = App.store.db.update {
//            obj?.username = "frankthameltest"
//            obj?.email = "frank.thamel@gmail.com"
//        }
//        print(isSaved ? "Saved" : "Not saved")
//
//        let isDeleted = App.store.db.delete(object: obj)
//        print(isDeleted ? "Deleted" : "Not deleted")


//        let isSaved = App.store.db.create(object: obj)


        // let results: DbResults<User>? = User.filterBy(username: "frankthame")
        //let allUsers: DbResults<User>? = User.all()

        let user = User.object(forId: "8FCBDEC2-07B1-490D-A012-077FBE944DF7")
        print(user?.email)

        let licensesController = TCLicenseViewController()
        licensesController.modalPresentationStyle = .fullScreen
        licensesController.title = "Licenses"
        licensesController.loadPlist(Bundle.main, resourceName: "Credits")
        self.navigationController?.pushViewController(licensesController, animated: true)
//        present(licensesController, animated: true, completion: {
//            licensesController.title = "Licenses"
//        })

    }

    @IBAction func showSuccessAlert(_ sender: Any) {
        let successAlertModel = SuccessAlertModel(descriptions: ["description" :"අතරමැදි වෙළෙන්දන්ගේ ඇතැම් ක්‍රියාකලාපයන් නිසාත්, හඳුනානොගත් රෝගයක් නිසාත් කිතුල් ආශ්‍රිත කර්මාන්තය දිනෙන් දින අභාවයට යමින් පවතින... "] , containerController: self)
        let falierAlertModel = FalierAlertModel(descriptions: ["description" :"අතරමැදි වෙළෙන්දන්ගේ ඇතැම් ක්‍රියාකලාපයන් නිසාත්, හඳුනානොගත් රෝගයක් නිසාත් කිතුල් ආශ්‍රිත කර්මාන්තය දිනෙන් දින අභාවයට යමින් පවතින... "] , containerController: self)
        let infoAlertModel = InfoAlertModel(descriptions: ["description" :"අතරමැදි වෙළෙන්දන්ගේ ඇතැම් ක්‍රියාකලාපයන් නිසාත්, හඳුනානොගත් රෝගයක් නිසාත් කිතුල් ආශ්‍රිත කර්මාන්තය දිනෙන් දින අභාවයට යමින් පවතින... "] , containerController: self)
        App.managers.alert.showAlert(model: infoAlertModel)


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

    @IBAction func shareImage(_ sender: Any) {
        let image = #imageLiteral(resourceName: "TaleneSchoolPost")
        App.services.socialShareService.facebookService.share(image: image, hashTag: "#TaleneSchool", inViewController: self, delegate: self)

        print(App.settings.configs.lc.developerDetails ?? "")
    }

    @IBAction func shareImages(_ sender: Any) {
        let image = #imageLiteral(resourceName: "TaleneSchoolPost")
        let image2 = #imageLiteral(resourceName: "TaleSchoolPost2")
        App.services.socialShareService.facebookService.share(images: [image, image2], hashTag: "#TaleneSchool", inViewController: self, delegate: self)
    }

    @IBAction func shareUrl(_ sender: Any) {
        App.services.socialShareService.facebookService.share(urlString: "https://www.hirunews.lk", withComment: "ශ්‍රී ලංකාවෙන් වාර්තාවන කොරෝනා වෛරස් ආසාදිතයන් සංඛ්‍යාව 1790ක් දක්වා ඉහළ ගොස් තිබෙනවා.", hashTag: "#TaleneSchool", inViewController: self, delegate: self)
    }

    @IBAction func shareText(_ sender: Any) {
        App.services.socialShareService.facebookService.share(comment: "Stop the spread!", hashTag: "#TaleneSchool", inViewController: self, delegate: self)
    }


    /// Banner Ads
    @IBOutlet weak var bannerAdsView: FirebaseBannerAdsView!

    private func setAndLoadBannerAds() {
        App.services.firebaseService.firebaseAdsService.bannerAdsService.setUp(bannerAd: bannerAdsView, rootViewController: self, delegate: self)
        App.services.firebaseService.firebaseAdsService.bannerAdsService.loadBannerAd(bannerAd: bannerAdsView)
    }

    /// Video Ads
    @IBAction func loadVideoAds(_ sender: Any) {
        App.services.firebaseService.firebaseAdsService.videoAdsService.presentVideoAd(fromRootViewController: self, delegate: self)
    }


}

extension ViewController: FacebookServiceDelegate {
    func didCompleteWithResults(results: [String : Any]) {
        print(results)
    }

    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }

    func didCancel() {
        print("Facebook share cancelled.")
    }
}

extension ViewController: FirebaseBannerAdsDelegate {
    func adViewDidReceiveAd() {
        print("adViewDidReceiveAd")
    }

    func didFailToReceiveAdWithError(error: Error) {
        print("didFailToReceiveAdWithError")
    }

    func adViewWillPresentScreen() {
        print("adViewWillPresentScreen")
    }
}

extension ViewController: FirebaseVideoAdsDelegate {
    func userDidEarnReward(reward: Int) {
        print("Rewarded: \(reward)")
    }
}

