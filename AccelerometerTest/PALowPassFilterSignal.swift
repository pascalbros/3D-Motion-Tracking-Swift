struct PALowPassFilterSignal {
    /// Current signal value
    var value: Double
    
    /// A scaling factor in the range 0.0..<1.0 that determines
    /// how resistant the value is to change
    let filterFactor: Double

    /// Update the value, using filterFactor to attenuate changes
    mutating func update(newValue: Double) {
        value = filterFactor * value + (1.0 - filterFactor) * newValue
    }
}

struct PA3AxisLowPassFilterSignal {
    /// Current signal value
    var lowPassX: PALowPassFilterSignal!
    var lowPassY: PALowPassFilterSignal!
    var lowPassZ: PALowPassFilterSignal!
    /// Update the value, using filterFactor to attenuate changes
    
    mutating func setup(filterFactor: Double) {
        self.lowPassX = PALowPassFilterSignal(value: 0.0, filterFactor: filterFactor)
        self.lowPassY = PALowPassFilterSignal(value: 0.0, filterFactor: filterFactor)
        self.lowPassZ = PALowPassFilterSignal(value: 0.0, filterFactor: filterFactor)
    }
    
    mutating func update(newValueX: Double, newValueY: Double, newValueZ: Double) {
        lowPassX.update(newValueX)
        lowPassY.update(newValueY)
        lowPassZ.update(newValueZ)
    }
    
    func xValue() -> Double {
        return self.lowPassX.value
    }
    
    func yValue() -> Double {
        return self.lowPassY.value
    }
    
    func zValue() -> Double {
        return self.lowPassZ.value
    }
}


func exponentialMovingAverage(currentAverage: Double, newValue: Double, smoothing: Double) -> Double {
    return smoothing * newValue + (1 - smoothing) * currentAverage
}
