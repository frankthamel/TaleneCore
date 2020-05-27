//
//  MessageFactory.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/27/20.
//

import Foundation
import SwiftMessages

protocol MessageFactory {
    func createMessage(model: MessageModel) -> MessageView
}

public class MessageFactoryImpl: MessageFactory {
    func createMessage(model: MessageModel) -> MessageView {
        var view = MessageView.viewFromNib(layout: model.viewType)

        view.configureContent(title: model.title, body: model.subTitle, iconImage: model.icon, iconText: model.iconText, buttonImage: nil, buttonTitle: TCSay.Messages.hide, buttonTapHandler: { _ in SwiftMessages.hide() })
        switch model.type {
            case .info:
                configureWarningTheme(forView: &view, model: model)
            case .success:
                configureSuccessTheme(forView: &view, model: model)
            case .error:
                configureFailTheme(forView: &view, model: model)
            case .plain:
                configurePlainTheme(forView: &view, model: model)
            case .custom(let backgroundColor, let foregroundColor, let iconImage, let iconText):
                configureCustomTheme(forView: &view, backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage, iconText: iconText)
        }
        return view
    }

    func configureSuccessTheme(forView view: inout MessageView, model: MessageModel) {
        view.configureTheme(backgroundColor: App.settings.theme.successColor, foregroundColor: App.settings.theme.foregroundColor)
    }

    func configureFailTheme(forView view: inout MessageView, model: MessageModel) {
        view.configureTheme(backgroundColor: App.settings.theme.falierColor, foregroundColor: App.settings.theme.foregroundColor)
    }

    func configureWarningTheme(forView view: inout MessageView, model: MessageModel) {
        view.configureTheme(backgroundColor: App.settings.theme.infoColor, foregroundColor: App.settings.theme.foregroundColor)
    }

    func configurePlainTheme(forView view: inout MessageView, model: MessageModel) {
        view.configureTheme(.info, iconStyle: model.iconStyle)
    }

    func configureCustomTheme(forView view: inout MessageView, backgroundColor: UIColor, foregroundColor: UIColor, iconImage: UIImage?, iconText: String?) {
        view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage, iconText: iconText)
    }
}
