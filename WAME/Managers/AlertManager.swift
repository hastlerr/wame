//
//  AlertManager.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/19/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import UIKit

class AlertManager {
    
    static private var rootViewConroller: UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
    
    static func showErrorAlert(with message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootViewConroller.present(alertVC, animated: true, completion: nil)
    }
    
    static func showWhatsAppMissingAlert() {
        let whatsAppDownloadURL = URL(string: "https://www.whatsapp.com/download")!
        
        let alertVC = UIAlertController(title: "WhatsApp is not installed", message: "Please download WhatsApp", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Download", style: .destructive, handler: { (_) in
            UIApplication.shared.open(whatsAppDownloadURL, options: [:], completionHandler: nil)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        rootViewConroller.present(alertVC, animated: true, completion: nil)
    }
    
}
