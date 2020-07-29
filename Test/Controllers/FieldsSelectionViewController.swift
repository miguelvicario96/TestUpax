//
//  FieldsSelectionViewController.swift
//  Test
//
//  Created by Miguel Vicario on 28/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class FieldsSelectionViewController: UIViewController {
    
    //MARK: - Properties
    private var selectedRows: [String] = []
    
    //MARK: - View
    public var fieldSelectionView: FieldSelectionView! {
        guard isViewLoaded else { return nil }
        return (view as! FieldSelectionView)
    }
    
    //MARK: - Life Cycle
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        cellRegistration()
    }
    
    //MARK: - Methods
    private func cellRegistration() {
        fieldSelectionView.tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldCell")
    }
    
    //MARK: - Actions
    @IBAction public func checkFields(_ sender: UIButton) {
        if !selectedRows.isEmpty {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoView") as! InfoViewController
            vc.selectedRows = selectedRows
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "No Hay Elementos Seleccionados", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - UITableViewDataSource
extension FieldsSelectionViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FieldsData.dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as! FieldTableViewCell
        
        cell.fieldNameLabel.text = FieldsData.dataArray[indexPath.row]
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FieldsSelectionViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedRows.append(FieldsData.dataArray[indexPath.row])
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            
            guard let removeIndex = selectedRows.firstIndex(of: FieldsData.dataArray[indexPath.row]) else { return }
            selectedRows.remove(at: removeIndex)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
