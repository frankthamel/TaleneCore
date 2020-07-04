//
//  PopoverManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/4/20.
//

import Foundation
import Popover

public typealias TCPopoverOption = PopoverOption

public protocol PopUp {
    func show(view: UIView, atPoint point: CGPoint, options: [TCPopoverOption]?)
    func show(view: UIView, atPoint point: CGPoint, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?)
    func show(view: UIView, fromFrame frame: UIView, options: [TCPopoverOption]?)
    func show(view: UIView, fromFrame frame: UIView, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?)
}

class PopoverManager: PopUp {
    func show(view: UIView, atPoint point: CGPoint, options: [TCPopoverOption]?) {

        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(view, point: point)
    }

    func show(view: UIView, atPoint point: CGPoint, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        let popover = Popover(options: options, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.show(view, point: point)
    }

    func show(view: UIView, fromFrame frame: UIView, options: [TCPopoverOption]?) {
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(view, fromView: frame)
    }

    func show(view: UIView, fromFrame frame: UIView, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        let popover = Popover(options: options, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.show(view, fromView: frame)
    }
}
