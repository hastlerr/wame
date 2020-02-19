//
//  WhatsAppManager.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/19/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import UIKit

class WhatsAppManager {
    
    private static let whatsAppBaseURL = "whatsapp://send?phone="
    
    static func openChat(number: String) {
        let chatURL = whatsAppBaseURL + number
        if let urlString = chatURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    AlertManager.showWhatsAppMissingAlert()
                }
            }
        }
    }
    
    func checkClipboard(number: String) {

        
    }
    
}
