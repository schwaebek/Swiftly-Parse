//
//  FacesTVC.swift
//  Swiftly Parse
//
//  Created by Katlyn Schwaebe on 8/26/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

import UIKit
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class FacesTVC: UITableViewController {
    
    var faces: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var someHeight = SCREEN_HEIGHT - 100
        
        Parse.setApplicationId("LtCW4Yo9U6Y0SyYl5UXFhBSFEIzfZbJ5B59FNqVk", clientKey: "zAszv83ewf1LZabMpapaRDP2ym68OhsyL3toJPX1")
        self.refreshData()
        
        var nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserverForName("faceSave", object: nil, queue: NSOperationQueue.mainQueue()){ (notification:NSNotification!) -> Void in
            self.refreshData()
        }
       
    }
        func refreshData() {
        var query = PFQuery(className: "Faces")
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            self.faces = objects
            self.tableView.reloadData()
            }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return faces.count
    }

        override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as FaceCell
        var faceInfo = faces[indexPath.row] as PFObject
            var file = faceInfo.objectForKey("image") as PFFile
            cell.faceView.image = UIImage(data: file.getData())

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func newFace(sender: UIBarButtonItem) {
        let navC = UINavigationController(rootViewController: IWAViewController())
        
        self.navigationController.presentViewController(navC, animated: true) { () -> Void in
        }
        
    }

}
