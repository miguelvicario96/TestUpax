//
//  BirthDateTableViewCell.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class BirthDateTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet public weak var birthTextField: UITextField!
    
    //MARK: - Properties
    let datePicker = UIDatePicker()
    
    //MARK: - Life Cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        createDatePicker()
    }
    
    //MARK: - Methods
    private func createDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 35))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        birthTextField.inputAccessoryView = toolbar
        birthTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc private func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        birthTextField.text = formatter.string(from: datePicker.date)
        self.contentView.endEditing(true)
    }
}
