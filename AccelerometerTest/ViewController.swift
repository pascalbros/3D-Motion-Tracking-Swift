//
//  ViewController.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 16/04/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import UIKit
import CoreMotion
import SceneKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: PA3DTrackingView!

    @IBOutlet weak var distanceLabel: UILabel!
    
    let positionLogger = PAPositionLogger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        self.positionLogger.onUpdate = {logger in
        
            self.updateNodePosition()
            self.updateLabel()
        }
        
        //Uncomment this to disable the kalman filter
        //self.positionLogger.usekalmanFilter = false
        self.reset()
    }
    
    private func start() {
        self.positionLogger.start()
    }
    
    private func stop() {
        self.positionLogger.stop()
        self.reset()
    }
    
    private func reset() {
        self.updateLabel()
        self.updateNodePosition()
    }
    
    private func updateLabel() {
        
        let position = self.positionLogger.lastPosition
        self.distanceLabel.text = String(format: "X: %.2f m Y:%.2f m Z:%.2f m", position.x, position.y, position.z)

    }
    
    private func updateNodePosition() {
        //We will use a multiplier in order to amplify the movement into the scene
        let mul = 80.0
        let position = self.positionLogger.lastPosition
        
        self.sceneView.setPointerPosition(x: position.x * mul, y: position.y * mul, z: position.z * mul)
        
    }
    
    @IBAction func didReset(sender: UIButton) {
        if sender.currentTitle == "Start" {
            sender.setTitle("Stop", forState: .Normal)
            self.start()
        }else{
            sender.setTitle("Start", forState: .Normal)
            self.stop()
        }
    }
}

