//
//  MyInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import QRCode
import QRCodeReader
import AVFoundation
import Foundation

var myInfo = ContactInfoStruct()

class MyInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var instaField: UITextField!
    @IBOutlet weak var fbField: UITextField!
    @IBOutlet weak var linkedField: UITextField!
    
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        phoneField.delegate = self
        fbField.delegate = self
        
        nameField.isUserInteractionEnabled = false
        phoneField.isUserInteractionEnabled = false
        fbField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        instaField.isUserInteractionEnabled = false
        linkedField.isUserInteractionEnabled = false
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
            emailField.isUserInteractionEnabled = true
            instaField.isUserInteractionEnabled = true
            linkedField.isUserInteractionEnabled = true
        }
        else {
           editButton.setTitle("Edit", for: UIControlState.normal)
            myInfo.name = nameField.text!
            myInfo.phoneNum = phoneField.text!
            myInfo.fbName = fbField.text!
            myInfo.email = emailField.text!
            myInfo.instagram = instaField.text!
            myInfo.linkedin = linkedField.text!
            nameField.isUserInteractionEnabled = false
            phoneField.isUserInteractionEnabled = false
            fbField.isUserInteractionEnabled = false
            emailField.isUserInteractionEnabled = false
            instaField.isUserInteractionEnabled = false
            linkedField.isUserInteractionEnabled = false
            qrCode = QRCode(parse(obj: myInfo))
            img = qrCode?.image
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
