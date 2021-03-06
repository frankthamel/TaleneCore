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

    var membershipListener: TCListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()

        // load onboarding view
        let onboardingDatasource = [
            OnboardingModel(informationImage: #imageLiteral(resourceName: "img1"), title: "The standard Lorem Ipsum passage, used since the 1500s", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", color: UIColor.white, descriptionLabelPadding: 30, titleLabelPadding: 30),
            OnboardingModel(informationImage: #imageLiteral(resourceName: "img2"), title: "The standard Lorem Ipsum passage, used since the 1500s", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", color: UIColor.white, descriptionLabelPadding: 30, titleLabelPadding: 30),
            OnboardingModel(informationImage: #imageLiteral(resourceName: "img3"), title: "The standard Lorem Ipsum passage, used since the 1500s", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", color: UIColor.white, descriptionLabelPadding: 30, titleLabelPadding: 30),
            OnboardingModel(informationImage: #imageLiteral(resourceName: "img3"), title: "The standard Lorem Ipsum passage, used since the 1500s", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", color: UIColor.white, descriptionLabelPadding: 30, titleLabelPadding: 30),
            OnboardingModel(informationImage: #imageLiteral(resourceName: "img3"), title: "The standard Lorem Ipsum passage, used since the 1500s", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", color: UIColor.white, descriptionLabelPadding: 30, titleLabelPadding: 30)
            ].compactMap { $0 }
        //App.managers.onboarding.show(info: onboardingDatasource, inViewController: self)

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


        TCRun.afterDelay(seconds: 120) {
            let membership = Membership(id: "TCTest", type: .pro)
            App.services.firebaseService.firebaseCloudFireStoreService.create(item: membership, withDocumentId: "abc", in: "Membership") { (result) in
                switch result {
                case .success:
                    print("Membership saved")
                case .failure:
                    print("Membership saving error")
                }
            }
        }

        print("Tets timmer text")
        let saleEndDate = DateComponents(calendar: .current, year: 2020, month: 7, day: 28, hour: 5, minute: 9).date!
        print("saleEndDate: \(saleEndDate.toTimmerText(from: Date()))")

        TCRun.afterDelay(seconds: 125) {
            print("Tets timmer text")
            let saleEndDate = DateComponents(calendar: .current, year: 2020, month: 7, day: 28, hour: 5, minute: 9).date!
            print("saleEndDate: \(saleEndDate.toTimmerText(from: Date()))")
        }


        // Test
        let today =  DateComponents(calendar: .current, year: 2020, month: 7, day: 24, hour: 5, minute: 9).date!
        print("Today is \(today.today()) \(today.isWeekend()) \(today.isDay(.friday)) \(today.isDay(.monday))")
        let tomorrow =  DateComponents(calendar: .current, year: 2020, month: 7, day: 25, hour: 5, minute: 9).date!
        print("Tomorrow is \(tomorrow.today()) \(tomorrow.isWeekend()) \(tomorrow.isDay(.friday)) \(tomorrow.isDay(.monday))")
        let dayAfterTomorrow =  DateComponents(calendar: .current, year: 2020, month: 7, day: 26, hour: 5, minute: 9).date!
        print("Day after tomorrow is \(dayAfterTomorrow.today()) \(dayAfterTomorrow.isWeekend()) \(dayAfterTomorrow.isDay(.friday)) \(dayAfterTomorrow.isDay(.monday))")

        print(today.toNumbers().year)
        print(today.toNumbers().month)
        print(today.toNumbers().day)
        print(today.toNumbers().hour)
        print(today.toNumbers().minute)
        print(today.toNumbers().second)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDevice.deviceID()

        membershipListener = App.services.firebaseService.firebaseCloudFireStoreService.addListener(toCollection: "Membership", documentId: "abc", withCompletion: { (result: Result<Membership, TCFirestoreError>) in
            switch result {
            case .success(let membership):
                print("Membership id: ", membership.id)
                print("Membership type: ", membership.type)
            case .failure:
                print("error")
            }
        })

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dbRefreshToken?.invalidate()
        membershipListener?.remove()
    }

    deinit {
        print("Viewcontroller deinit.")
        App.managers.notification.localNotificationManager.removeObserver(inClass: self)
    }

    @IBAction func showInfoAlert(_ sender: Any) {
         //let alertModel = InfoAlertModel(descriptions: [TCConstants.description : TCSay.Alerts.sign_in_verification_failed] , containerController: self)
        let alertModel = CustomAlertModel(type: .custom(AppAlerts.createSignInWithEmailAlert), params: [TCConstants.isFirebase: true], containerController: self)


//        let model = AdsShareModel(title: "Title of the push message.", message: "Our website is well-organized and navigable so that it???s easy to find what you need. We create an environment for your children that is safe, secure and supportive. Our parent???s area enables the parents to find out their children???s progress. They can help children in their learning and development by purchasing the new items of Talene. We design activities that provide children with opportunities to develop physically, socially, emotionally, morally, cognitively and creatively.", hashTags: [], openUrl: "https://www.google.com/", shareUrl: "https://taleneschool.com", image: nil)
//        let alertModel = CustomAlertModel(type: .custom(AppAlerts.createTCAdsAlert), params: [TCConstants.model: model], containerController: self)
        
        App.managers.alert.showAlert(model: alertModel)

        //App.managers.message.showMessageView(BuyAppCard.self)

        print(UserDevice.deviceID())
    }

    @IBAction func showErrorAlert(_ sender: Any) {
        //let alertModel = FalierAlertModel(descriptions: ["description" :"This is a Test message."] , containerController: self)
        //App.managers.alert.showAlert(model: alertModel)



        if App.managers.connection.isReachable() {
            let messegeModel = MessageModel(title: "????", subTitle: "Have internet connection.", type: .success, presentationContext: .statusBar)
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
        let successAlertModel = SuccessAlertModel(descriptions: ["description" :"????????????????????? ????????????????????????????????? ??????????????? ?????????????????????????????????????????? ??????????????????, ?????????????????????????????? ?????????????????? ?????????????????? ?????????????????? ????????????????????? ??????????????????????????? ?????????????????? ????????? ?????????????????? ??????????????? ???????????????... "] , containerController: self)
        let falierAlertModel = FalierAlertModel(descriptions: ["description" :"????????????????????? ????????????????????????????????? ??????????????? ?????????????????????????????????????????? ??????????????????, ?????????????????????????????? ?????????????????? ?????????????????? ?????????????????? ????????????????????? ??????????????????????????? ?????????????????? ????????? ?????????????????? ??????????????? ???????????????... "] , containerController: self)
        let infoAlertModel = InfoAlertModel(descriptions: ["description" :"????????????????????? ????????????????????????????????? ??????????????? ?????????????????????????????????????????? ??????????????????, ?????????????????????????????? ?????????????????? ?????????????????? ?????????????????? ????????????????????? ??????????????????????????? ?????????????????? ????????? ?????????????????? ??????????????? ???????????????... "], actions: ["Yes": { print("Clear Data")}, "No": { print("Don't Clear Data")}], containerController: self)
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
        App.services.socialShareService.facebookService.share(urlString: "https://www.hirunews.lk", withComment: "??????????????? ???????????????????????? ???????????????????????? ?????????????????? ??????????????? ??????????????????????????? ???????????????????????? 1790?????? ??????????????? ????????? ???????????? ?????????????????????.", hashTag: "#TaleneSchool", inViewController: self, delegate: self)
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

