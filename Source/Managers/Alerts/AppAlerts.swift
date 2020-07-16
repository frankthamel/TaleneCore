//
//  AppAlerts.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit
import Foundation
import Malert

public typealias TCAlert = Malert

// MARK: Alert Factory
protocol AlertFactory {
    func createAlert(model: AlertModel) -> Malert
}

public class AppAlerts: NSObject, AlertFactory {

    public var customAlertsCreators: [String : (AlertModel) -> Malert] = [:]
    func createAlert(model: AlertModel) -> Malert {
        switch model.type {
        case .success:
            return createSuccessAlert(model: model)
        case .error:
            return createErrorAlert(model: model)
        case .info:
            return createInfoAlert(model: model)
        case .custom(let customAlertFunc):
            return customAlertFunc(model)
        }
    }
}

// MARK: Custom Alert Views
extension AppAlerts {

    private func createDefaultAlerts(_ model: AlertModel) -> Malert {
        let alertView = DefaultAlertUIView.instantiateFromNib()
        var buttonsColor = App.settings.theme.successColor

        alertView.titleLabel.text = model.title ?? ""
        alertView.descriptionLabel.text = model.descriptions[TCConstants.description]

        switch model.type {
        case .success:
            alertView.iconImageView.image = UIImage(withFrameworkName: "CheckMark")
            buttonsColor = App.settings.theme.successColor
        case .error:
            alertView.iconImageView.image = UIImage(withFrameworkName: "ErrorIcon")
            buttonsColor = App.settings.theme.falierColor
        case .info:
            alertView.iconImageView.image = UIImage(withFrameworkName: "InfoIcon")
            buttonsColor = App.settings.theme.infoColor
        default:
            break
        }

        let alert = Malert(customView: alertView)

        alert.separetorColor = .clear
        alert.backgroundColor = .clear
        alert.cornerRadius = 20
        alert.buttonsHeight = 55

        if let font = UIFont(name: "Helvetica", size: 20) {
            alert.buttonsFont = font
        }

        if let modelActions = model.actions, modelActions.count > 0 {
            let closeAction = MalertAction(title: TCSay.Alerts.cancel)
            closeAction.tintColor = UIColor.white
            closeAction.backgroundColor = App.settings.theme.subColorTwo
            alert.addAction(closeAction)

            for (key, value) in modelActions {
                let action = MalertAction(title: key, actionBlock: value)
                action.tintColor = UIColor.white
                action.backgroundColor = buttonsColor
                alert.addAction(action)
            }

            alert.buttonsSpace = 2
            alert.buttonsAxis = .horizontal

        } else {
            let action = MalertAction(title: TCSay.Alerts.ok)
            action.tintColor = UIColor.white
            action.backgroundColor = buttonsColor
            alert.addAction(action)
        }

        return alert
    }

    func createSuccessAlert(model: AlertModel) -> Malert {
        let successModel = model
        successModel.title = TCSay.Alerts.success
        successModel.closeButtonName = TCSay.Alerts.ok
        App.managers.hapticFeedback.trigger(.success)
        return createDefaultAlerts(successModel)
    }

    func createErrorAlert(model: AlertModel) -> Malert {
        let errorModel = model
        errorModel.title = TCSay.Alerts.error
        errorModel.closeButtonName = TCSay.Alerts.close
        App.managers.hapticFeedback.trigger(.error)
        return createDefaultAlerts(errorModel)
    }

    func createInfoAlert(model: AlertModel) -> Malert {
        let infoModel = model
        infoModel.title = TCSay.Alerts.info
        infoModel.closeButtonName = TCSay.Alerts.close
        App.managers.hapticFeedback.trigger(.warning)
        return createDefaultAlerts(infoModel)
    }
}
