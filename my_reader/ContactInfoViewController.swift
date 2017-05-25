//
//  ContactInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit
import CoreData

class ContactInfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fbLabel: UILabel!
    @IBOutlet weak var instagramField: UILabel!
    @IBOutlet weak var linkedinField: UILabel!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var a: ContactInfoStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = a.name
        phoneLabel.text = a.phoneNum
        emailLabel.text = a.email
        fbLabel.text = a.fbName
        instagramField.text = a.instagram
        linkedinField.text = a.linkedin
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
