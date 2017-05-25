//
//  MyInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import CoreData
var myInfo = [NSManagedObject]()

class MyInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fbField: UITextField!
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var linkedinField: UITextField!
    
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        fbField.delegate = self
        instagramField.delegate = self
        linkedinField.delegate = self
        
        nameField.isUserInteractionEnabled = false
        phoneField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        fbField.isUserInteractionEnabled = false
        instagramField.isUserInteractionEnabled = false
        linkedinField.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClick(_ sender: UIButton) {
        editMode = !editMode
        checkEditMode()
    }
    
    func saveMyself(name: String, phoneNum: String, email: String, fbName: String, instagram: String, linkedin: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Contact",
                                       in: managedContext)!
        
        let contact = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        contact.setValue(name, forKeyPath: "name")
        contact.setValue(email, forKeyPath: "email")
        contact.setValue(phoneNum, forKeyPath: "phoneNum")
        contact.setValue(fbName, forKeyPath: "fbName")
        contact.setValue(instagram, forKeyPath: "instagram")
        contact.setValue(linkedin, forKeyPath: "linkedin")
        
        // 4
        do {
            try managedContext.save()
            if (myInfo.count != 0) {
                myInfo[0] = contact
            }
            else {
                myInfo.append(contact)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(myInfo.count)
    }
    
    public func checkEditMode() {
        if editMode == true {
            editButton.setTitle("Save", for: UIControlState.normal)
            nameField.isUserInteractionEnabled = true
            phoneField.isUserInteractionEnabled = true
            emailField.isUserInteractionEnabled = true
            fbField.isUserInteractionEnabled = true
            instagramField.isUserInteractionEnabled = true
            linkedinField.isUserInteractionEnabled = true

        }
        else {
           editButton.setTitle("Edit", for: UIControlState.normal)
            nameField.isUserInteractionEnabled = false
            phoneField.isUserInteractionEnabled = false
            emailField.isUserInteractionEnabled = false
            fbField.isUserInteractionEnabled = false
            instagramField.isUserInteractionEnabled = false
            linkedinField.isUserInteractionEnabled = false
            
            let nameToSave = self.nameField.text
            let phoneToSave = self.phoneField.text
            let emailToSave = self.nameField.text
            let fbToSave = self.fbField.text
            let instagramToSave = self.instagramField.text
            let linkedinToSave = self.linkedinField.text
        
            self.saveMyself(name: nameToSave!, phoneNum: phoneToSave!, email: emailToSave!, fbName: fbToSave!, instagram: instagramToSave!, linkedin: linkedinToSave!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
