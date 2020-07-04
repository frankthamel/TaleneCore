//
//  PopoverManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/4/20.
//

import UIKit
import Popover

public typealias TCPopoverOption = PopoverOption

public protocol PopUp {
    func show(view: TCPopoverView, atPoint point: CGPoint, options: [TCPopoverOption]?)
    func show(view: TCPopoverView, atPoint point: CGPoint, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?)
    func show(view: TCPopoverView, fromFrame frame: UIView, options: [TCPopoverOption]?)
    func show(view: TCPopoverView, fromFrame frame: UIView, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?)
}

class PopoverManager: PopUp {
    func show(view: TCPopoverView, atPoint point: CGPoint, options: [TCPopoverOption]?) {
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        view.popover = popover
        popover.show(view, point: point)
    }

    func show(view: TCPopoverView, atPoint point: CGPoint, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        let popover = Popover(options: options, showHandler: showHandler, dismissHandler: dismissHandler)
        view.popover = popover
        popover.show(view, point: point)
    }

    func show(view: TCPopoverView, fromFrame frame: UIView, options: [TCPopoverOption]?) {
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        view.popover = popover
        popover.show(view, fromView: frame)
    }

    func show(view: TCPopoverView, fromFrame frame: UIView, options: [TCPopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        let popover = Popover(options: options, showHandler: showHandler, dismissHandler: dismissHandler)
        view.popover = popover
        popover.show(view, fromView: frame)
    }
}

public class TCPopoverView: UIView {
    weak var popover: Popover?
}
