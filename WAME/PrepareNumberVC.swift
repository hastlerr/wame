//
//  PrepareNumberVC.swift
//  WAME
//
//  Created by Avaz on 10/4/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class PrepareNumberVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var openChatButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        openChatButton.layer.cornerRadius = 5
        openChatButton.layer.masksToBounds = true
        
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(chekClipboardData),
                                               name:  UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    fileprivate func removeObserver(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }

    @objc func chekClipboardData() {
        if let clipboard = UIPasteboard.general.string, clipboard.isPhoneNumber, numberTextField.text != clipboard{
            numberTextField.insertText(clipboard)
        }
    }

    @IBAction func openChatButtonTapped(){
        guard let number = numberTextField.text, !number.isEmpty else {
            showAlert(message: "Please enter number")
            return
        }
        openChat(number: number)
    }
    
    fileprivate func openChat(number: String) {
        let urlWhats = "whatsapp://send?phone=\(number)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                } else {
                    showAlert(message: "WhatsApp not installed")
                }
            }
        }
    }
    
    fileprivate func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}


extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

