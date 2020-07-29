//
//  SettingsView.swift
//  Test
//
//  Created by Miguel Vicario on 28/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

@IBDesignable open class CornerView: UIView {
    
    @IBInspectable var cornerRadius: Double {
        get { return Double(self.layer.cornerRadius) }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }
    
    override open func awakeFromNib() {
        
    }
}

private var maxLengths = [UITextField: Int]()
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else { return 100 }
            return length
        }
        
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fixMax), for: .editingChanged)
        }
    }
    
    @objc func fixMax(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedTo(length: maxLength)
    }
}
