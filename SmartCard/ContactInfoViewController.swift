//
//  ContactInfoViewController.swift
//  SmartCard
//
//  Created by Kevin Kou
//  Copyright © 2017 Kevin Kou. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    var a: String!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = parse(str: a)
        
        let name = b.name
        let contactInfo = "Phone: " + parsePhoneNumber(usPhone: b.phoneNum) + "\n\n" + "Facebook: " + b.fbName + "\n\n" + "Email: " + b.email + "\n\n" + "Instagram: " + b.instagram + "\n\n" + "Linkedin: " + b.linkedin + "\n\n"
        let textString = "\n\(name)\n\n\(contactInfo)"
        
        let attrText = NSMutableAttributedString(string: textString)
        
        let largeFont = UIFont(name: "Arial-BoldMT", size: 30.0)!
        let smallFont = UIFont(name: "Arial", size: 16.0)!
        
        //  Convert textString to NSString because attrText.addAttribute takes an NSRange.
        let largeTextRange = (textString as NSString).range(of: name)
        let smallTextRange = (textString as NSString).range(of: contactInfo)
        
        attrText.addAttribute(NSFontAttributeName, value: largeFont, range: largeTextRange)
        attrText.addAttribute(NSFontAttributeName, value: smallFont, range: smallTextRange)
        
        textView.attributedText = attrText
        

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
