//
//  ViewController.swift
//  webtask-demo
//
//  Created by Julien Regnauld on 7/19/16.
//  Copyright © 2016 Julien Regnauld. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let applicationUser = ApplicationUser()
    let webtaskService = WebtaskService()
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    webtaskService.send(applicationUser) { (result) in
      dispatch_async(dispatch_get_main_queue(), {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        switch result {
          case .Success() :
            self.displayAlertMessage("Device information uploaded with success")
          case .Error():
            self.displayAlertMessage("Something went wrong")
        }
      })
    }

  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension UIViewController {
  func displayAlertMessage(message: String, function:(()->())? = nil) {
    let alertController = UIAlertController(title: "Webtask", message: message, preferredStyle: .Alert)
    let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) -> Void in
      if let function = function {
        function()
      }
    }
    alertController.addAction(cancelAction)
    self.presentViewController(alertController, animated: true, completion: nil)
  }

}
