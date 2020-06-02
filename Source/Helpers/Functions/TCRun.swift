//
//  TCRun.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation

public struct TCRun {
    public static func afterDelay(seconds: Double, after: @escaping () -> Void) {
        afterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }

    public static func afterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: { self.onMainThread { after() } })
    }

    public static func onMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    public static func onBackgroundThread(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async(execute: { self.onMainThread { block() } })
    }
}
