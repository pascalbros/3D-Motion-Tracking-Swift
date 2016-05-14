//
//  AppDelegate.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 16/04/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        let filter = PAKalmanFilter()
//        //filter.currentState = PAKalmanState(q: 0.0625, r: 4.0, x: 0.0, p: 0.469, k: 0.1174)
//        filter.currentState = PAKalmanState(q: 0.0625, r: 2.0, x: 0.0, p: 0.0, k: 0.0)
//        
//        let data = KalmanTest.data
//        for a in data {
//            filter.update(a[2])
//            let s = String(format: ";%f;%f", a[2], filter.currentValue).stringByReplacingOccurrencesOfString(".", withString: ",")
//            print(s)
//        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

