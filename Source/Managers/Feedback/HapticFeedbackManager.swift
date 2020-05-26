//
//  HapticFeedbackManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/26/20.
//

import Foundation

public protocol FeedbackGenerator {
    func trigger(_ type: UINotificationFeedbackGenerator.FeedbackType)
    func impact()
    func select()
}

struct HapticFeedbackManager: FeedbackGenerator {
    private let generator = UINotificationFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .light)
    let selectionGenerator = UISelectionFeedbackGenerator()

    func trigger(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }

    func impact() {
        impactGenerator.impactOccurred()
    }

    func select() {
        selectionGenerator.selectionChanged()
    }

}
