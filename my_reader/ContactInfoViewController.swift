//
//  ContactInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var fbLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var instaLabel: UILabel!
    @IBOutlet weak var linkedLabel: UILabel!


    var a: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let b = parse(a)
        nameLabel.text = "name: " +  b.name
        phoneLabel.text = "phone: " + b.phoneNum
        fbLabel.text = "facebook: " + b.fbName
        emailLabel.text = "email: " + b.email
        instaLabel.text = "instagram: " + b.instagram
        linkedLabel.text = "linkedin: " + b.linkedin

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
