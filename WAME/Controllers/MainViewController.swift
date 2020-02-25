//
//  PrepareNumberVC.swift
//  WAME
//
//  Created by Avaz on 10/4/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit
import PhoneNumberKit

class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var textField: PhoneNumberTextField!
    @IBOutlet weak var openChatButton: UIButton!
    
    // MARK: - Lifecycle API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openChatButton.layer.cornerRadius = 5
        openChatButton.layer.masksToBounds = true
        setupTextField()
        Notifications.sceneDidBecomeActive.addObserver(self, selector: #selector(sceneDidBecomeActive))
    }
    
    func setupTextField() {
        PhoneNumberKit.CountryCodePicker.commonCountryCodes = ["US", "CA", "MX", "AU", "GB", "DE"]
        textField.withPrefix = true
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.withDefaultPickerUI = true
        
    }
    
    // MARK: - Private API
    
    var countryCode: String {
        let currentRegion = textField.currentRegion
        let code = textField.phoneNumberKit.countryCode(for: currentRegion)!
        return "\(code)"
    }
    
    func preparePhoneNumber(_ number: inout String) -> String {
       
        if let index = number.firstIndex(of: "+") {
            number.remove(at: index)
        }
        
        if textField.withPrefix {
            return number
        } else {
            return countryCode + number
        }
        
    }
    
    private func showKeyboardToolBar(with number: String) {
        let bar = UIToolbar()
        bar.tintColor = .black
        
        let numberButton = UIBarButtonItem(title: number, style: .plain, target: self, action: #selector(pasteTextToTextField(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        bar.items = [flexibleSpace, numberButton, flexibleSpace]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
        
    }
    
    @objc func pasteTextToTextField(sender: UIBarButtonItem) {
        if let number = sender.title {
            textField.text = number
            textField.updateFlag()
            textField.updatePlaceholder()
        }
        
        textField.inputAccessoryView = nil
        textField.reloadInputViews()
        
    }
    
    // MARK: - Actions
    
    @IBAction func clearTextFieldTapped(){
        textField.text = ""
        textField.updatePlaceholder()
    }
    
    @IBAction func openChatButtonTapped(){
        
        guard let text = textField.text, !text.isEmpty else {
            AlertManager.showErrorAlert(with: "Please enter number")
            return
        }
        
        guard text.count > 5 else {
            AlertManager.showErrorAlert(with: "The number is too short")
            return
        }
        
        let internationalNumber = countryCode + textField.nationalNumber
        
        WhatsAppManager.openChat(number: internationalNumber)
        
    }
    
    @IBAction func openNumberSettingsTapped() {
        let alertController = UIAlertController(title: "Configuration", message: nil, preferredStyle: .actionSheet)
        let settingsView = NumberSettingsView()
        settingsView.setupView(with: textField)
        
        alertController.view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 45).isActive = true
        settingsView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        settingsView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 380).isActive = true
        
        let chooseCountries = UIAlertAction(title: "Choose country", style: .default) { (_) in
            self.textField.didPressFlagButton()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseCountries)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Notification Handlers
    
    @objc func sceneDidBecomeActive() {
        if let clipboard = UIPasteboard.general.string?.digitsOnly(), clipboard.count < 20, clipboard.count >= 8 {
            showKeyboardToolBar(with: clipboard)
        }
    }
    
    
}
