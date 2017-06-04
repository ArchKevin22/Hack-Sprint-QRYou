//
//  ContactTableViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    static var contactsList: [String] {
        get {
            if let returnValue = UserDefaults.standard.object(forKey: "contactsList") as? [String] {
                return returnValue == [] ? ["John Doe,5555555555,john.doe@yandex.ru,https://facebook.com/john.doe,https://instagram.com/johndoe,https://linkedin.com/in/john.doe", "Apple,1234567890,eggert@cs.ucla.edu,https://github.com/eggert,https://instagram.com/vim123,http://www.bruinwalk.com/professors/paul-r-eggert/"] : returnValue
            } else {
                return ["John Doe,5555555555,john.doe@yandex.ru,https://facebook.com/john.doe,https://instagram.com/johndoe,https://linkedin.com/in/john.doe", "Apple,1234567890,eggert@cs.ucla.edu,https://github.com/eggert,https://instagram.com/vim123,http://www.bruinwalk.com/professors/paul-r-eggert/"] //Default value
            }
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "contactsList")
            //NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    var a = ContactInfoStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //         Create a variable that you want to send
        let object = ContactTableViewController.contactsList[tableView.indexPathForSelectedRow!.row]
        //         Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! ContactInfoViewController
        destinationVC.a = object
    }


    //    public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    //
    //        //         Create a variable that you want to send
    //        let object = contactsList[tableView.indexPathForSelectedRow!.row]
    //
    //        //         Create a new variable to store the instance of PlayerTableViewController
    //        let destinationVC = segue.destination as! ContactTableViewController
    //        destinationVC.a = object
    //    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactTableViewController.contactsList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = parse(str: ContactTableViewController.contactsList[indexPath.row]).name
        return cell
    }


    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below

        // Create an instance of PlayerTableViewController and pass the variable
        //        let destinationVC = ContactTableViewController()
        //        destinationVC.a = temp

        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        performSegue(withIdentifier: "contactsSegue", sender: self)
    }


    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        ContactTableViewController.contactsList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.tableView.reloadData()
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */


    //    public func prepareForSegue->(UIStoryboardSegue *)segue sender:(id)sender {
    //        if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
    //            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //            RecipeDetailViewController *destViewController = segue.destinationViewController;
    //            destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
    //    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}
