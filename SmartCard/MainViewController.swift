//
//  MainViewController.swift
//  SmartCard
//
//  Created by Alex Oh
//  Copyright © 2017 alexswo. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
import QRCodeReader
import QRCode

class MainViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func reloadImage() {
        appDelegate.img = (appDelegate.qrCode?.image)!
        imageView.image = appDelegate.img
    }
    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })

    @IBAction func getCode(_ sender: Any) {
        appDelegate.qrCode = QRCode(appDelegate.myInfo[segmentedControl.selectedSegmentIndex])

        reloadImage()
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.qrCode = QRCode(appDelegate.myInfo[segmentedControl.selectedSegmentIndex])
        reloadImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // String
        appDelegate.qrCode = QRCode(appDelegate.myInfo[0])
        appDelegate.img = appDelegate.qrCode?.image
        imageView.image = appDelegate.img
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

    // MARK: - QRCodeReader Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()

        dismiss(animated: true) { [weak self] in
            let my_string = result.value
            let value_arr = my_string.components(separatedBy: ",")
            let alert = UIAlertController(
                title: "Success!",
                message: String (format:"Name: %@\nPhone Number: %@\nE-Mail: %@\nFacebook: %@\nInstagram: %@\nLinkedIn: %@", value_arr[0],parsePhoneNumber(usPhone: value_arr[1]),value_arr[2],value_arr[3],value_arr[4],value_arr[5]),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.appDelegate.contactsList.append(my_string)

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
