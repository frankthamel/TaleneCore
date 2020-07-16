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

public class AlertModel {
    public var title: String?
    public var descriptions: [String : String]
    public var type : AlertType
    public var actions: [String : AlertAction]?
    public var params: [String : Any]?
    public weak var malert: Malert?
    public var closeAction: AlertAction?
    public var closeButtonName: String?
    public var containerController: UIViewController

    public init(title: String? = nil, descriptions: [String : String], type : AlertType, actions: [String : AlertAction]? = nil, params: [String : Any]? = nil, malert: Malert? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        self.title = title
        self.descriptions = descriptions
        self.type = type
        self.actions = actions
        self.params = params
        self.malert = malert
        self.closeAction = closeAction
        self.closeButtonName = closeButtonName
        self.containerController = containerController
    }
}

public enum AlertType {
    case success
    case error
    case info
    case custom((AlertModel) -> Malert)
}

public class SuccessAlertModel: AlertModel {

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        super.init(title: title, descriptions: descriptions, type: .success, actions: actions, closeAction: closeAction, closeButtonName: closeButtonName, containerController: containerController)
    }

}

public class FalierAlertModel: AlertModel {

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        super.init(title: title, descriptions: descriptions, type: .error, actions: actions, closeAction: closeAction, closeButtonName: closeButtonName, containerController: containerController)
    }
}

public class InfoAlertModel: AlertModel {

    public init(title: String? = nil, descriptions: [String : String], actions: [String : AlertAction]? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        super.init(title: title, descriptions: descriptions, type: .info, actions: actions, closeAction: closeAction, closeButtonName: closeButtonName, containerController: containerController)
    }
}

public class CustomAlertModel: AlertModel {

    public init(title: String? = nil, type: AlertType, actions: [String : AlertAction]? = nil, params: [String : Any]? = nil, malert: Malert? = nil, closeAction: AlertAction? = nil, closeButtonName: String? = nil, containerController: UIViewController) {
        super.init(title: title, descriptions: [:], type: type, actions: actions, params: params, malert: malert, closeAction: closeAction, closeButtonName: closeButtonName, containerController: containerController)
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
