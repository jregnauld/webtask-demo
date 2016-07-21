//
//  ApplicationUserTests.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/20/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable
import webtask_demo
class ApplicationUserTests: QuickSpec {
  
  let defaults = NSUserDefaults()
  override func spec() {
    it("returns correct data") {
      var applicationUser = ApplicationUser()
      let version: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String + " (" + (NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String) + ")"
      expect(applicationUser.name) == UIDevice.currentDevice().name
      expect(applicationUser.currentDevice) == Device.CURRENT_DEVICE
      expect(applicationUser.currentSystem) == Device.CURRENT_VERSION
      expect(applicationUser.country) == Device.CURRENT_REGION
      expect(applicationUser.timeZone) == NSTimeZone.localTimeZone().name
      expect(applicationUser.getVersion()) == version
      expect(applicationUser.lastConnection) == NSDate().now()
      expect(applicationUser.UUID) == self.defaults.stringForKey("UUID")
    }
    it("will never return UUID as null") {
      self.defaults.removeObjectForKey("UUID")
      expect(self.defaults.stringForKey("UUID")).to(beNil())
      var applicationUser = ApplicationUser()
      expect(applicationUser.UUID).notTo(beNil())
    }
  }
}
