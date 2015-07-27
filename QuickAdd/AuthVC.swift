//
//  AuthVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Wlite
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
        
        let successHandler:AuthorizeSuccessHandler = {(_) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
        }
        
        let failureHandler : AuthorizeFailureHandler = { (error) -> Void in
            println("authorization failed: \(error)")
            Drop.down("Error: \(error)", state: .Error)
        }

        App.wlite.authorize(successHandler, failureHandler: failureHandler)
    }

}
