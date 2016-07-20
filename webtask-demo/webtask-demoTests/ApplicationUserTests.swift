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
  let applicationUser = ApplicationUser()
  let defaults = NSUserDefaults()

  override func spec() {
    it("returns correct data") {
      let version: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String + " (" + (NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String) + ")"
      expect(self.applicationUser.name) == UIDevice.currentDevice().name
      expect(self.applicationUser.currentDevice) == Device.CURRENT_DEVICE
      expect(self.applicationUser.currentSystem) == Device.CURRENT_VERSION
      expect(self.applicationUser.country) == Device.CURRENT_REGION
      expect(self.applicationUser.timeZone) == NSTimeZone.localTimeZone().name
      expect(self.applicationUser.getVersion()) == version
      expect(self.applicationUser.lastConnection) == NSDate().now()
    }
  }
}
