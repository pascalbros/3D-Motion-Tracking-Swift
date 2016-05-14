//
//  PAKalmanFilter.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 03/05/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import UIKit

struct PAKalmanState {
    var q: Double //process noise covariance
    var r: Double //measurement noise covariance
    var x: Double //value
    var p: Double //estimation error covariance
    var k: Double //kalman gain
}

class PAKalmanFilter: NSObject {
    
    var currentMeasurementNoiseCovariance: Double {
        get { return self.currentState.r }
    }
    
    var currentProcessNoiseCovariance: Double {
        get { return self.currentState.q }
    }
    
    var currentValue: Double {
        get { return self.currentState.x }
    }
    
    var currentEstimationErrorCovariance: Double {
        get { return self.currentState.p }
    }
    
    var kalmanGain: Double {
        get { return self.currentState.k }
    }
    
    var currentState = PAKalmanState(q: 0, r: 0, x: 0, p: 0, k: 0)
    
    func update(measurement: Double) {
        
        //prediction update
        //omit x = x
        self.currentState.p = self.currentState.p + self.currentState.q
        
        //measurement update
        self.currentState.k = self.currentState.p / (self.currentState.p + self.currentState.r)
        self.currentState.x = self.currentState.x + self.currentState.k * (measurement - self.currentState.x)
        self.currentState.p = (1.0 - self.currentState.k) * self.currentState.p
    }
}

class PA3DKalmanFilter: NSObject {
    var xFilter = PAKalmanFilter()
    var yFilter = PAKalmanFilter()
    var zFilter = PAKalmanFilter()
    
    func setup(state: PAKalmanState) {
        xFilter.currentState = PAKalmanState(q: state.q, r: state.r, x: state.x, p: state.p, k: state.k)
        yFilter.currentState = PAKalmanState(q: state.q, r: state.r, x: state.x, p: state.p, k: state.k)
        zFilter.currentState = PAKalmanState(q: state.q, r: state.r, x: state.x, p: state.p, k: state.k)
        
    }
    
    func update(x: Double, y: Double, z: Double) {
        self.xFilter.update(x)
        self.yFilter.update(y)
        self.zFilter.update(z)
    }
}


