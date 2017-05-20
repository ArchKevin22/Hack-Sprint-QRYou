//
//  MyInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
var myInfo = ContactInfoStruct()

class MyInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var fbField: UITextField!
    
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        phoneField.delegate = self
        fbField.delegate = self
        
        nameField.isUserInteractionEnabled = false
        phoneField.isUserInteractionEnabled = false
        fbField.isUserInteractionEnabled = false
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
    
    public func checkEditMode() {
        if editMode == true {
            editButton.setTitle("Save", for: UIControlState.normal)
            nameField.isUserInteractionEnabled = true
            phoneField.isUserInteractionEnabled = true
            fbField.isUserInteractionEnabled = true
        }
        else {
           editButton.setTitle("Edit", for: UIControlState.normal)
            myInfo.name = nameField.text!
            myInfo.phoneNum = phoneField.text!
            myInfo.fbName = fbField.text!
            nameField.isUserInteractionEnabled = false
            phoneField.isUserInteractionEnabled = false
            fbField.isUserInteractionEnabled = false
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
