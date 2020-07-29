//
//  InfoView.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class InfoView: UIView {
    
    //MARK: - Outlets
    @IBOutlet public weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
}
