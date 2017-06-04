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


class MyInfoViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var instaField: UITextField!
    @IBOutlet weak var fbField: UITextField!
    @IBOutlet weak var linkedField: UITextField!
    @IBOutlet weak var editButton: UIButton!

    var editMode = false

    @IBAction func switchCode(_ sender: Any) {
        let b = parse(str: MainViewController.myInfo[segControl.selectedSegmentIndex])
        nameField.text = b.name
        phoneField.text = b.phoneNum
        emailField.text = b.email
        fbField.text = b.fbName
        instaField.text = b.instagram
        linkedField.text = b.linkedin
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        phoneField.delegate = self
        fbField.delegate = self
        emailField.delegate = self
        instaField.delegate = self
        linkedField.delegate = self

        nameField.isUserInteractionEnabled = false
        phoneField.isUserInteractionEnabled = false
        fbField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        instaField.isUserInteractionEnabled = false
        linkedField.isUserInteractionEnabled = false
        
        let b = parse(str: MainViewController.myInfo[segControl.selectedSegmentIndex])
        nameField.text = b.name
        phoneField.text = b.phoneNum
        emailField.text = b.email
        fbField.text = b.fbName
        instaField.text = b.instagram
        linkedField.text = b.linkedin
        
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
          if (nameField.text?.characters.count != 0 && phoneField.text?.characters.count != 0 && fbField.text?.characters.count != 0 && emailField.text?.characters.count != 0 && instaField.text?.characters.count != 0 && linkedField.text?.characters.count != 0) &&
            (nameField.text?.characters.index(of: ",") != nil || phoneField.text?.characters.index(of: ",") != nil || fbField.text?.characters.index(of: ",") != nil || emailField.text?.characters.index(of: ",") != nil || instaField.text?.characters.index(of: ",") != nil || linkedField.text?.characters.index(of: ",") != nil) {
              let alert = UIAlertController (
                  title: "Error",
                  message: "No commas allowed! Commas are an illegal character. Please remove it.",
                  preferredStyle: .alert
              )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
          }
          else {
            editButton.setTitle("Edit", for: UIControlState.normal)
            let temp = ContactInfoStruct()
            temp.name = nameField.text!
            temp.phoneNum = phoneField.text!
            temp.fbName = fbField.text!
            temp.email = emailField.text!
            temp.instagram = instaField.text!
            temp.linkedin = linkedField.text!
            nameField.isUserInteractionEnabled = false
            phoneField.isUserInteractionEnabled = false
            fbField.isUserInteractionEnabled = false
            emailField.isUserInteractionEnabled = false
            instaField.isUserInteractionEnabled = false
            linkedField.isUserInteractionEnabled = false
            let str = parse(obj: temp)
            MainViewController.myInfo[segControl.selectedSegmentIndex] = str
            }
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
