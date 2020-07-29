//
//  NumberTableViewCell.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class NumberTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet public weak var numberTextField: UITextField!
    
    //MARK: - Life Cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
