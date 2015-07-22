//
//  AuthVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Common
import SwiftyDrop

class AuthVC: UIViewController {
    
    @IBOutlet weak var authenticateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("AuthVC did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func authenticateButtonTapped(sender: AnyObject) {
        
        let callbackURL = "https://dl.dropboxusercontent.com/u/33491043/sites/wlite/quickadd/success.html"
        let successHandler : WliteAuthorizeSuccessHandler = { (token) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
               
            });
        }
        let failureHandler : WliteAuthorizeFailureHandler = { (error) -> Void in
            println("authorization failed: \(error)")
            Drop.down("Error: \(error)", state: .Error)
        }
        
        Wlite.authorizeWithCallbackURL(callbackURL, successHandler: successHandler, failureHandler: failureHandler);
    }

}
