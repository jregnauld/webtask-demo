//
//  WebtaskServiceTests.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/21/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable
import webtask_demo

class WebtaskServiceTests: QuickSpec {
  let webtaskService = WebtaskService()
  let applicationUser = ApplicationUser()
  override func spec() {
    afterEach {
      OHHTTPStubs.removeAllStubs()
    }
    it("will send information with success") {
      stub(isHost(ProjectURL.webtaskHost) && isPath(ProjectURL.webtaskPath)) { _ in
        return OHHTTPStubsResponse(data: NSData(), statusCode: 200, headers: nil)
      }
      var isSuccess = false
      waitUntil { done in
        self.webtaskService.send(self.applicationUser, completed: { (result) -> Void in
          switch result {
            case .Success():
              isSuccess = true
            case .Error():
              isSuccess = false
          }
          expect(isSuccess).to(beTrue())
          done()
        })
      }
    }
    it("something went wrong when sending information") {
      stub(isHost(ProjectURL.webtaskHost) && isPath(ProjectURL.webtaskPath)) { _ in
        return OHHTTPStubsResponse(data: NSData(), statusCode: 400, headers: nil)
      }
      var isFailure = false
      waitUntil { done in
        self.webtaskService.send(self.applicationUser, completed: { (result) -> Void in
          switch result {
          case .Success():
            isFailure = false
          case .Error():
            isFailure = true
          }
          expect(isFailure).to(beTrue())
          done()
        })
      }
    }
  }
}