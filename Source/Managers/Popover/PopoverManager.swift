//
//  PopoverManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/4/20.
//

import Foundation
import Popover

public protocol PopUp {
    func show(view: UIView, atPoint point: CGPoint)
    func show(view: UIView, atPoint point: CGPoint, showHandler: (() -> ())?, dismissHandler: (() -> ())?)
}

class PopoverManager: PopUp {
    func show(view: UIView, atPoint point: CGPoint) {
        let popover = Popover(options: nil, showHandler: nil, dismissHandler: nil)
        popover.show(view, point: point)
    }

    func show(view: UIView, atPoint point: CGPoint, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        let popover = Popover(options: nil, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.show(view, point: point)
    }
}
