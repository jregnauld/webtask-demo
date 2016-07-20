//
//  NSDate+webstask.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/19/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//
import Foundation

extension NSDate {
  func now() -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.stringFromDate(self)
    return dateString
  }
}
