//
//  AlertManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/11/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit
import Malert

// MARK: Alert Models
public typealias AlertAction = () -> Void

public protocol AlertModel {
    var title: String? { get set }
    var descriptions: [String : String] { get set }
    var type : AlertType { get set }
    var actions: [String : AlertAction]? { get set }
    var closeAction: AlertAction? { get set }
    var closeButtonName: String? { get set }
    var containerController: UIViewController { get set }
}

public enum AlertType {
    case success
    case error
    case info
    case custom(CustomAlertViewType)
}

public struct SuccessAlertModel: AlertModel {

    public var title: String?

    public var descriptions: [String : String]

    public var type: AlertType = .success

    public var actions: [String : AlertAction]?

    public var closeAction: AlertAction?

    public var closeButtonName: String?

    public var containerController: UIViewController

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        self.title = title
        self.descriptions = descriptions
        self.actions = actions
        self.closeAction = closeAction
        self.closeButtonName = closeButtonName
        self.containerController = containerController
    }

}

public struct FalierAlertModel: AlertModel {

    public var title: String?

    public var descriptions: [String : String]

    public var type: AlertType = .error

    public var actions: [String : AlertAction]?

    public var closeAction: AlertAction?

    public var closeButtonName: String?

    public var containerController: UIViewController

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        self.title = title
        self.descriptions = descriptions
        self.actions = actions
        self.closeAction = closeAction
        self.closeButtonName = closeButtonName
        self.containerController = containerController
    }
}

public struct InfoAlertModel: AlertModel {

    public var title: String?

    public var descriptions: [String : String]

    public var type: AlertType = .info

    public var actions: [String : AlertAction]?

    public var closeAction: AlertAction?

    public var closeButtonName: String?

    public var containerController: UIViewController

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        self.title = title
        self.descriptions = descriptions
        self.actions = actions
        self.closeAction = closeAction
        self.closeButtonName = closeButtonName
        self.containerController = containerController
    }
}

public struct CustomAlertModel: AlertModel {

    public var title: String?

    public var descriptions: [String : String] = [:]

    public var type: AlertType

    public var actions: [String : AlertAction]? = nil

    public var closeAction: AlertAction? = nil

    public var closeButtonName: String? = TCSay.Alerts.close

    public var containerController: UIViewController

    public init(title: String? = nil, descriptions: [String : String] = [:], type: AlertType, actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        self.title = title
        self.descriptions = descriptions
        self.type = type
        self.actions = actions
        self.closeAction = closeAction
        self.closeButtonName = closeButtonName
        self.containerController = containerController
    }
}

// MARK: Alert Manager

public protocol Alert {
    func showAlert(model: AlertModel)
}

struct AlertManager: Alert {

    let alertFactory : AlertFactory = AppAlerts()

    func showAlert(model: AlertModel) {
        let alert = alertFactory.createAlert(model: model)

        if let parent = model.containerController.parent {
            parent.present(alert, animated: true, completion: nil)
        } else {
            model.containerController.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: Alert Factory

protocol AlertFactory {
    func createAlert(model: AlertModel) -> Malert
}
