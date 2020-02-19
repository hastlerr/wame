//
//  NumberSettingsView.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/16/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import UIKit
import PhoneNumberKit

class NumberSettingsView: UIView {

    // MARK: - IB Outlets
    
    @IBOutlet var withPrefixSwitch: UISwitch!
    @IBOutlet var withFlagSwitch: UISwitch!
    @IBOutlet var withExamplePlaceholderSwitch: UISwitch!

    var textField: PhoneNumberTextField!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let bundle = Bundle.init(for: NumberSettingsView.self)
        if let viewsToAdd = bundle.loadNibNamed("NumberSettingsView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }

    func setupView(with textField: PhoneNumberTextField) {
        self.textField = textField

        self.textField.becomeFirstResponder()
        self.withPrefixSwitch.isOn = self.textField.withPrefix
        self.withFlagSwitch.isOn = self.textField.withFlag
        self.withExamplePlaceholderSwitch.isOn = self.textField.withExamplePlaceholder
        
    }

    // MARK: - Actions

    @IBAction func withExamplePlaceholderDidChange(_ sender: UISwitch) {
        textField.withExamplePlaceholder = sender.isOn
        textField.updatePlaceholder()
        if !self.textField.withExamplePlaceholder {
            self.textField.placeholder = "Enter phone number"
        }
    }

    @IBAction func withPrefixDidChange(_ sender: UISwitch) {
        textField.withPrefix = sender.isOn
    }

    @IBAction func withFlagDidChange(_ sender: UISwitch) {
        textField.withFlag = sender.isOn
    }

}
