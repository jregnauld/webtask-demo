//
//  AppDelegate.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/19/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import UIKit
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    let UUID = UIDevice.currentDevice().identifierForVendor?.UUIDString
    let currentDevice = Device.CURRENT_DEVICE
    let currentSystem = Device.CURRENT_VERSION
    let name = UIDevice.currentDevice().name
    let region = Device.CURRENT_REGION
    let timeZone = NSTimeZone.localTimeZone().name
    var applicationVersion:String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    var applicationBuild:String = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
 
    print("UUID:", UUID)
    print("currentDevice:", currentDevice)
    print("currentSystem:", currentSystem)
    print("name:", name)
    print("Date:", NSDate().now())
    print(region)
    print(timeZone)
    print(applicationVersion)
    print(applicationBuild)
    var params = ["UUID": UUID!,
                  "deviceType": currentDevice,
                  "systemVersion": currentSystem,
                  "deviceName": name,
                  "country": region,
                  "timeZone": timeZone,
                  "version": applicationVersion + " (" + applicationBuild + ")",
                  "lastConnection": NSDate().now()];
    Alamofire.request(.GET, "https://webtask.it.auth0.com/api/run/wt-j_regnauld-gmail_com-0/webtask-demo", parameters: params)
      .validate(statusCode: 200..<300)
      .response { response in
        print(response.2)
        
    }
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

