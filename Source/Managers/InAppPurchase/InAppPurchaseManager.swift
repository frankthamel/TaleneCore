//
//  InAppPurchaseManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 8/11/20.
//

import Foundation
import SwiftyStoreKit
import StoreKit

public protocol InAppPurchase: AppConfigure {
    func retrieveProductsInfo(forIds ids: [String], withCompletion completion: @escaping (Set<SKProduct>?) -> Void)
    func purchaseProduct(id: String, withCompletion completion: @escaping (Bool, String) -> Void)
    func purchaseProduct(product: SKProduct, withCompletion completion: @escaping (Bool, String) -> Void)
    func purchaseProduct(id: String, forUser applicationUsername: String, isSandbox: Bool, withCompletion completion: @escaping (Bool, String) -> Void)
    func restorePurchases(withCompletion completion: @escaping ([Purchase]?) -> Void)
    func restorePurchases(forUser applicationUsername: String, withCompletion completion: @escaping ([Purchase]?) -> Void)
    func fetchReceipt(withCompletion completion: @escaping (Bool) -> Void)
    func verifyReceipt(forProductId productId: String, withKey key: String, service: StoreKitService, withCompletion completion: @escaping (Bool) -> Void)
}

class InAppPurchaseManager: InAppPurchase {
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing

                default:
                    break
                }
            }
        }
    }

    func retrieveProductsInfo(forIds ids: [String], withCompletion completion: @escaping (Set<SKProduct>?) -> Void) {
        SwiftyStoreKit.retrieveProductsInfo(Set(ids)) { result in
            let products = result.retrievedProducts
            if !products.isEmpty {
                completion(products)
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                App.managers.logger.error(message: "Invalid product identifier: \(invalidProductId)")
                completion(nil)
            }
            else {
                App.managers.logger.error(message: print("Error: \(result.error?.localizedDescription ?? "")"))
                completion(nil)
            }
        }
    }

    func purchaseProduct(id: String, withCompletion completion: @escaping (Bool, String) -> Void) {
        SwiftyStoreKit.purchaseProduct(id, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                //purchase.transaction.transactionIdentifier
                completion(true, "Purchase Success: \(purchase.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: completion(false, "Unknown error. Please contact support.")
                case .clientInvalid: completion(false, "Not allowed to make the payment.")
                case .paymentCancelled: completion(false, "Payment cancelled.")
                case .paymentInvalid: completion(false, "The purchase identifier was invalid")
                case .paymentNotAllowed: completion(false, "The device is not allowed to make the payment")
                case .storeProductNotAvailable: completion(false, "The product is not available in the current storefront")
                case .cloudServicePermissionDenied: completion(false, "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: completion(false, "Could not connect to the network")
                case .cloudServiceRevoked: completion(false, "User has revoked permission to use this cloud service")
                default: completion(false, error.localizedDescription)
                }
            }
        }
    }

    func purchaseProduct(product: SKProduct, withCompletion completion: @escaping (Bool, String) -> Void) {
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                completion(true, "Purchase Success: \(purchase.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: completion(false, "Unknown error. Please contact support.")
                case .clientInvalid: completion(false, "Not allowed to make the payment.")
                case .paymentCancelled: completion(false, "Payment cancelled.")
                case .paymentInvalid: completion(false, "The purchase identifier was invalid")
                case .paymentNotAllowed: completion(false, "The device is not allowed to make the payment")
                case .storeProductNotAvailable: completion(false, "The product is not available in the current storefront")
                case .cloudServicePermissionDenied: completion(false, "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: completion(false, "Could not connect to the network")
                case .cloudServiceRevoked: completion(false, "User has revoked permission to use this cloud service")
                default: completion(false, error.localizedDescription)
                }
            }
        }
    }

    func purchaseProduct(id: String, forUser applicationUsername: String, isSandbox: Bool, withCompletion completion: @escaping (Bool, String) -> Void) {

        self.retrieveProductsInfo(forIds: [id]) { (skProducts) in
            guard let products = skProducts, let product = products.first else {
                completion(false, "The purchase identifier was invalid")
                return
            }

            SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true, applicationUsername: applicationUsername, simulatesAskToBuyInSandbox: isSandbox) { (result) in
                switch result {
                case .success(let purchase):
                    completion(true, "Purchase Success: \(purchase.productId)")
                case .error(let error):
                    switch error.code {
                    case .unknown: completion(false, "Unknown error. Please contact support.")
                    case .clientInvalid: completion(false, "Not allowed to make the payment.")
                    case .paymentCancelled: completion(false, "Payment cancelled.")
                    case .paymentInvalid: completion(false, "The purchase identifier was invalid")
                    case .paymentNotAllowed: completion(false, "The device is not allowed to make the payment")
                    case .storeProductNotAvailable: completion(false, "The product is not available in the current storefront")
                    case .cloudServicePermissionDenied: completion(false, "Access to cloud service information is not allowed")
                    case .cloudServiceNetworkConnectionFailed: completion(false, "Could not connect to the network")
                    case .cloudServiceRevoked: completion(false, "User has revoked permission to use this cloud service")
                    default: completion(false, error.localizedDescription)
                    }
                }
            }
        }
    }

    func restorePurchases(withCompletion completion: @escaping ([Purchase]?) -> Void) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                App.managers.logger.error(message: "Restore Failed: \(results.restoreFailedPurchases)")
                completion(nil)
            }
            else if results.restoredPurchases.count > 0 {
                App.managers.logger.info(message: "Restore Success: \(results.restoredPurchases)")
                completion(results.restoredPurchases)
            }
            else {
                App.managers.logger.error(message: "Nothing to Restore")
                completion(nil)
            }
        }
    }

    func restorePurchases(forUser applicationUsername: String, withCompletion completion: @escaping ([Purchase]?) -> Void) {
        SwiftyStoreKit.restorePurchases(atomically: true, applicationUsername: applicationUsername) { (results) in
            if results.restoreFailedPurchases.count > 0 {
                App.managers.logger.error(message: "Restore Failed: \(results.restoreFailedPurchases)")
                completion(nil)
            }
            else if results.restoredPurchases.count > 0 {
                App.managers.logger.info(message: "Restore Success: \(results.restoredPurchases)")
                completion(results.restoredPurchases)
            }
            else {
                App.managers.logger.error(message: "Nothing to Restore")
                completion(nil)
            }
        }
    }

    func fetchReceipt(withCompletion completion: @escaping (Bool) -> Void) {
        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
            switch result {
            case .success(let receiptData):
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                App.managers.logger.info(message: "Successfully fetched the receipt.")
                print("Fetch receipt success:\n\(encryptedReceipt)")
                completion(true)
            case .error(let error):
                App.managers.logger.error(message: "Fetch receipt failed: \(error)")
                completion(false)
            }
        }
    }

    func verifyReceipt(forProductId productId: String, withKey key: String, service: StoreKitService, withCompletion completion: @escaping (Bool) -> Void) {
        let appleValidator = AppleReceiptValidator(service: service.urlType, sharedSecret: key)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)

                switch purchaseResult {
                case .purchased:
                    completion(true)
                case .notPurchased:
                    completion(false)
                }
            case .error(let error):
                App.managers.logger.error(message: "Receipt verification failed: \(error)")
                completion(false)
            }
        }
    }


}

public enum StoreKitService {
    case sandbox
    case production

    var urlType: AppleReceiptValidator.VerifyReceiptURLType {
        switch self {
        case .sandbox:
            return .sandbox
        case .production:
            return .production
        }
    }
}
