
//
//  ViewController.swift
//  my_reader
//
//  Created by Alex Oh
//  Copyright © 2017 alexswo. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
import QRCodeReader
import QRCode
import CoreData

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    func parse(c: NSManagedObject) -> String {
        var obj : ContactInfoStruct!
        obj.name = (c.value(forKeyPath: "name") as? String)!
        obj.phoneNum = (c.value(forKeyPath: "phoneNum") as? String)!
        obj.email = (c.value(forKeyPath: "email") as? String)!
        obj.fbName = (c.value(forKeyPath: "fbName") as? String)!
        obj.instagram = (c.value(forKeyPath: "instagram") as? String)!
        obj.linkedin = (c.value(forKeyPath: "linkedin") as? String)!
        var s = obj.name
        s += ","
        s += obj.phoneNum
        s += ","
        s += obj.email
        s += ","
        s += obj.fbName
        s += ","
        s += obj.instagram
        s += ","
        s += obj.linkedin
        
        return s
    }
    
    func loadImage() {
        if myInfo.count > 0 {
            let str = parse(c: myInfo[0])
            let qrCode = QRCode(str)
            let img = qrCode?.image
            imageView.image = img
        }
        else {
            let imgname = "nope.png"
            imageView.image = UIImage(named: imgname)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Me")
        
        //3
        do {
            myInfo = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(myInfo.count)
    }
    
    @IBAction func editMyInfo(_ sender: Any) {
        performSegue(withIdentifier: "editmyinfo", sender: sender)
    }
    // reader
    @IBAction func scanAction(_ sender: AnyObject) {
        do {
            if try QRCodeReader.supportsMetadataObjectTypes() {
                reader.modalPresentationStyle = .formSheet
                reader.delegate               = self
                
                reader.completionBlock = { (result: QRCodeReaderResult?) in
                    if let result = result {
                        print("Completion with result: \(result.value) of type \(result.metadataType)")
                    }
                }
                
                present(reader, animated: true, completion: nil)
            }
        } catch let error as NSError {
            switch error.code {
            case -11852:
                let alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler:nil)
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
            case -11814:
                let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            default:()
            }
        }

    }
    
    func save(str: String) {
        
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
        let new_str = str.components(separatedBy: ",")
        
        contact.setValue(new_str[0], forKeyPath: "name")
        contact.setValue(new_str[1], forKeyPath: "email")
        contact.setValue(new_str[2], forKeyPath: "phoneNum")
        contact.setValue(new_str[3], forKeyPath: "fbName")
        contact.setValue(new_str[4], forKeyPath: "instagram")
        contact.setValue(new_str[5], forKeyPath: "linkedin")
        
        // 4
        do {
            try managedContext.save()
            contactsList.append(contact)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            let my_string = result.value
            let value_arr = my_string.components(separatedBy: ",")
            self?.save(str: my_string)
            let alert = UIAlertController(
                title: "Success!",
                message: String (format:"Name: %@\nPhone Number: %@\nE-Mail: %@\nFacebook: %@\nInstagram: %@\nLinkedIn: %@", value_arr[0],value_arr[1],value_arr[2],value_arr[3],value_arr[4],value_arr[5]),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}
