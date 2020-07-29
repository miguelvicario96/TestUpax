//
//  NameTableViewCell.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class NameTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet public weak var nameTextField: UITextField!
    
    //MARK: - Life Cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.delegate = self
    }
}

extension NameTableViewCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        
        return true
    }
}
