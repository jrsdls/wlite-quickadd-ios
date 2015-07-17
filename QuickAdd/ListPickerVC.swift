//
//  ListPickerVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/13/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit

protocol ListPickerDelegate {
    func pickerVC(vc: ListPickerVC, didFinishPickingList list:WList)
    func pickerVCDidCancel(vc: ListPickerVC)
}

class ListPickerVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    var lists = [WList]()
    var delegate : ListPickerDelegate?
    var tap : UITapGestureRecognizer?
    
    @IBOutlet weak var tableView: UITableView!
    
    class var width : CGFloat {
        return 280
    }
    
    class var height : CGFloat {
        return 220
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        if self.respondsToSelector("edgesForExtendedLayout") {
//            self.edgesForExtendedLayout = .None;
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    func superViewTapped(tap: UITapGestureRecognizer) {
        if let superview = self.view.superview {
            superview.removeGestureRecognizer(tap)
            
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.view.frame = CGRect(x: superview.frame.width, y: self.view.frame.origin.y, width: ListPickerVC.width, height: ListPickerVC.height)
                }, completion: { (finished) -> Void in
                    self.view.removeFromSuperview()
                    self.delegate?.pickerVCDidCancel(self)
            })
        }
        
    }
    
    // MARK: - Operations
    
    func presentPickerFromRect(rect: CGRect, inView view: UIView, animated: Bool) {
        self.tap = UITapGestureRecognizer(target: self, action: "superViewTapped:")
        self.tap!.delegate = self
        view.addGestureRecognizer(self.tap!)
        
        view.addSubview(self.view)
        self.view.frame = CGRect(x: view.frame.width, y: rect.origin.y, width: ListPickerVC.width, height: ListPickerVC.height)
        self.tableView.frame = CGRect(x: 0, y: 0, width: ListPickerVC.width, height: ListPickerVC.height)
        
        let shadowPath = UIBezierPath(rect: self.view.bounds)
        self.view.layer.masksToBounds = false;
        self.view.layer.shadowColor = UIColor.blackColor().CGColor;
        self.view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0);
        self.view.layer.shadowOpacity = 0.75;
        self.view.layer.shadowPath = shadowPath.CGPath;
        
        if animated {
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.view.frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: ListPickerVC.width, height: ListPickerVC.height)
            }, completion: { (finished) -> Void in
            })
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate Methods
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view.isDescendantOfView(self.view ) {
            return false;
        }
        return true
    }

    // MARK: - UITableViewDataSource Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return lists.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPickerCellIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let list = lists[indexPath.row]
        cell.textLabel?.text = list.title.capitalizedString

        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("delegate: \(self.delegate)")
        if let superview = self.view.superview {
            superview.removeGestureRecognizer(self.tap!)
            
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.view.frame = CGRect(x: superview.frame.width, y: self.view.frame.origin.y, width: ListPickerVC.width, height: ListPickerVC.height)
                }, completion: { (finished) -> Void in
                    self.view.removeFromSuperview()
                    self.delegate?.pickerVC(self, didFinishPickingList: self.lists[indexPath.row])
            })
        }
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
