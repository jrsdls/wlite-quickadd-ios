//
//  MainVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("MainVC did load")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("MainVC.isAuthenticated " + (isAuthenticated() ? "yes" : "no"))
        if (!isAuthenticated()) {
            // TODO: show auth page
            performSegueWithIdentifier("showAuthVC", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Convenience Methods
    
    private func isAuthenticated() -> Bool{
        // TODO: this!
        return false;
    }

}
