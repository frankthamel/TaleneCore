//
//  MessageManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/27/20.
//

import Foundation
import SwiftMessages

public class MessageModel {
    var title: String
    var subTitle: String
    var type: MessageType
    var icon: UIImage?
    var iconText: String?
    var configs: SwiftMessages.Config = SwiftMessages.defaultConfig
    var viewType: MessageView.Layout = .cardView
    var iconStyle: IconStyle = .default
    var duration: SwiftMessages.Duration = .automatic

    init(title: String, subTitle: String, type: MessageType, icon: UIImage? = nil, viewType: MessageView.Layout = .cardView, iconStyle: IconStyle = .default, iconText: String? = nil, duration: SwiftMessages.Duration = .automatic) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
        self.icon = icon
        self.viewType = viewType
        self.iconStyle = iconStyle
        self.iconText = iconText
        self.duration = duration

        setupTaleneDefault()
    }

    private func setupTaleneDefault() {
        configs.presentationStyle = .top
        configs.presentationContext = .automatic
        configs.duration = duration
        configs.dimMode = .gray(interactive: false)
    }
}

public enum MessageType {
    case info
    case success
    case error
    case plain
    case custom(backgroundColor: UIColor, foregroundColor: UIColor, iconImage: UIImage?, iconText: String?)
}

public protocol Message {
    func showMessage(model: MessageModel)
}

struct MessageManager: Message {

    let messageFactory: MessageFactory = MessageFactoryImpl()

    func showMessage(model: MessageModel) {
        SwiftMessages.show(config: model.configs, view: messageFactory.createMessage(model: model))
    }
}
