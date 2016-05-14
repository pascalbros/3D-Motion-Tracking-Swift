//
//  PAStepCounter.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 03/05/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import UIKit
import CoreMotion

class PAPositionLogger: NSObject {

    var onUpdate:(PAPositionLogger)->Void = {_ in }
    
    var lastPosition: CMAcceleration {
        get {
            return _lastPosition
        }
    }
    
    var usekalmanFilter = true
    
    private let accelerometerLogger = PAAccelerometerLogger()
    
    private var lastAcceleration = CMAcceleration()
    private var lastVelocity = CMAcceleration()
    
    private var _lastPosition = CMAcceleration()
    
    private var lastAccelerationDot = 0.0
    
    private var startTime: NSTimeInterval = NSDate().timeIntervalSince1970
    private var lastResetTime: NSTimeInterval = NSDate().timeIntervalSince1970
    
    private var filter = PA3DKalmanFilter()
    
    override init() {
        super.init()
        self.setup()
    }
    
    private func setup() {
        self.reset()
        self.accelerometerLogger.onUpdate = {logger  in
        
            let now = NSDate().timeIntervalSince1970
            let time = now - self.startTime
            self.startTime = now
            
            self.lastAcceleration = logger.lastAcceleration
            
            self.lastVelocity = PAPositionLogger.calculateVelocity(self.lastVelocity, acceleration: self.lastAcceleration, time: CGFloat(time))
            
            
            self._lastPosition = PAPositionLogger.calculatePosition(self.lastPosition, acceleration: self.lastAcceleration, time: CGFloat(time), velocity: self.lastVelocity)
            
            
            self.onUpdate(self)
        }
    }
    
    func start() {
        self.reset()
        self.accelerometerLogger.start()
    }
    
    func stop() {
        self.accelerometerLogger.stop()
        self.reset()
    }
    
    private func reset() {
        
        self.startTime = NSDate().timeIntervalSince1970
        self.lastAcceleration = CMAcceleration()
        self.lastVelocity = CMAcceleration()
        self._lastPosition = CMAcceleration()
        
        self.accelerometerLogger.useKalmanFilter = self.usekalmanFilter
    }
    
    
    
    static private func calculateVelocity(oldVelocity: CMAcceleration, acceleration: CMAcceleration, time: CGFloat) -> CMAcceleration {
        var lastVelocity = oldVelocity
        
        lastVelocity.x += (acceleration.x * Double(time))
        lastVelocity.y += (acceleration.y * Double(time))
        lastVelocity.z += (acceleration.z * Double(time))
        
        return lastVelocity
    }
    
    
    static private func calculatePosition(lastPosition: CMAcceleration, acceleration: CMAcceleration, time: CGFloat, velocity: CMAcceleration) -> CMAcceleration {
        
        var lastPos = lastPosition
        
        lastPos.x += velocity.x * Double(time) + (0.5 * acceleration.x * Double(pow(time, 2)));
        lastPos.y += velocity.y * Double(time) + (0.5 * acceleration.y * Double(pow(time, 2)));
        lastPos.z += velocity.z * Double(time) + (0.5 * acceleration.z * Double(pow(time, 2)));
        
        return lastPos
    }
}
