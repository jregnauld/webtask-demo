//
//  ApplicationUser.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/20/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import Foundation
import UIKit

struct ApplicationUser {
  private let defaults: NSUserDefaults
  let name: String
  let currentDevice: String
  let currentSystem: String
  let country: String
  let timeZone: String
  let lastConnection: String
  var UUID: String {
    mutating get {
      if let UUID = self.defaults.stringForKey("UUID") {
        return UUID
      } else {
        guard let newUUID:String = UIDevice.currentDevice().identifierForVendor?.UUIDString else {
          return "undefined";
        }
        self.defaults.setObject(newUUID, forKey: "UUID")
        return newUUID
      }
    }
  }
  private var applicationVersion: String {
    guard let version  = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String else {
      return "undefined"
    }
    return version
  }
  private var applicationBuild: String {
    guard let build  = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as? String else {
      return "undefined"
    }
    return build
  }
  
  init() {
    self.defaults = NSUserDefaults.standardUserDefaults()
    self.name = UIDevice.currentDevice().name
    self.currentDevice = Device.CURRENT_DEVICE
    self.currentSystem = Device.CURRENT_VERSION
    self.country = Device.CURRENT_REGION
    self.timeZone = NSTimeZone.localTimeZone().name
    self.lastConnection = NSDate().now()
  }
  func getVersion() -> String {
    return self.applicationVersion + " (" + self.applicationBuild + ")"
  }
}
