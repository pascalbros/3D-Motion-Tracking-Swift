//
//  PAAccelerometerLogger.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 03/05/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import UIKit
import CoreMotion

class PAAccelerometerLogger: NSObject {
    var onUpdate:(PAAccelerometerLogger)->Void = {_ in }
    
    private let motionManager = CMMotionManager()
    private var _lastAcceleration = CMAcceleration()

    var useKalmanFilter = true
    
    var lastAcceleration: CMAcceleration {
        get {
            return self._lastAcceleration
        }
    }
    
    private var filter = PA3DKalmanFilter()
    
    override init() {
        super.init()
    }
    
    func start() {
        let queue = NSOperationQueue.mainQueue()
        self.filter.setup(PAKalmanState(q: 0.0625, r: 2.0, x: 0.0, p: 0.0, k: 0.0))
        
        self.motionManager.startDeviceMotionUpdatesToQueue(queue) {
            (data, error) in
            var update = data?.userAcceleration as CMAcceleration!
            if self.useKalmanFilter {
                self.filter.update(update.x, y: update.y, z: update.z)
                update = CMAcceleration(x: self.filter.xFilter.currentValue, y: self.filter.yFilter.currentValue, z: self.filter.zFilter.currentValue)
            }
            
            self._lastAcceleration = update
            self.onUpdate(self)
        }
    }
    
    func stop() {
        self.motionManager.stopDeviceMotionUpdates()
        self._lastAcceleration = CMAcceleration()
    }
}
