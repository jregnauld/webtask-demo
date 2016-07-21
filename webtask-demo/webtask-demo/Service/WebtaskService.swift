//
//  WebtaskService.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/21/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import Foundation
import Alamofire
enum WebtaskResultType {
  case Success()
  case Error()
}
class WebtaskService {
  let httpManager = Manager.sharedInstance
  
  func send(_applicationUser: ApplicationUser, completed:(result: WebtaskResultType) -> Void) {
    var applicationUser = _applicationUser
    let params: [String : AnyObject] = [
      "webtask_no_cache": 1,
      "UUID": applicationUser.UUID,
      "deviceType": applicationUser.currentDevice,
      "systemVersion": applicationUser.currentSystem,
      "deviceName": applicationUser.name,
      "country": applicationUser.country,
      "timeZone": applicationUser.timeZone,
      "version": applicationUser.getVersion(),
      "lastConnection": applicationUser.lastConnection];
    Manager.sharedInstance.request(.GET, ProjectURL.webtaskDemo, parameters: params).validate(statusCode: 200..<300).responseString { response in
      switch response.result {
        case .Success:
          completed( result: .Success())
        case .Failure(_):
          completed( result: .Error())
      }
    }
  }
}