//
//  InfoViewController.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class InfoViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Instance Properties
    private let store = TestStore()
    
    //MARK: - Properties
    public var selectedRows: [String] = []
    private var selectedGender = IndexPath()
    private var image = UIImage(named: "camara")
    
    //MARK: - View
    public var infoView: InfoView! {
        guard isViewLoaded else { return nil }
        return (view as! InfoView)
    }
    
    //MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        cellRegistration()
    }
    
    //MARK: - Methods
    private func cellRegistration() {
        infoView.tableView.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "NameCell")
        infoView.tableView.register(UINib(nibName: "NumberTableViewCell", bundle: nil), forCellReuseIdentifier: "NumberCell")
        infoView.tableView.register(UINib(nibName: "BirthDateTableViewCell", bundle: nil), forCellReuseIdentifier: "BirthCell")
        infoView.tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldCell")
        infoView.tableView.register(UINib(nibName: "CameraTableViewCell", bundle: nil), forCellReuseIdentifier: "CameraCell")
    }
}

//MARK: - UITableViewDataSource
extension InfoViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        selectedRows.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        selectedRows[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = selectedRows[section]
        
        switch section {
            case "Nombre Completo":
                return 1
            
            case "Número Telefónico":
                return 1
            
            case "Fecha de Nacimiento":
                return 1
            
            case "Sexo":
                return 2
            
            case "Cámara":
                return 1
                
            case "Foto":
                return 1

            case "Color Favorito":
                return 5
                
            default:
                return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellContent = selectedRows[indexPath.section]
        
        switch cellContent {
            case "Nombre Completo":
                let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameTableViewCell
                return cell
            
            case "Número Telefónico":
                let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath) as! NumberTableViewCell
                return cell
            
            case "Fecha de Nacimiento":
                let cell = tableView.dequeueReusableCell(withIdentifier: "BirthCell", for: indexPath) as! BirthDateTableViewCell
            return cell
            
            case "Sexo":
                let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as! FieldTableViewCell
                cell.fieldNameLabel.text = FieldsData.genderArray[indexPath.row]
                return cell
            
            case "Cámara":
                let cell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableViewCell
                cell.cellImage.image = image
                return cell
                
            case "Foto":
                let imageURL = "https://http2.mlstatic.com/vegeta-tamano-real-para-armar-en-papercraft-D_NQ_NP_892880-MLA26232224460_102017-F.jpg"
                let cell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableViewCell
                store.serviceCall(url: URL(string: imageURL)!) { (image) in
                    DispatchQueue.main.async {
                        cell.cellImage.image = image
                    }
                }
                
                return cell

            case "Color Favorito":
                let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as! FieldTableViewCell
                cell.fieldNameLabel.text = FieldsData.colorsArray[indexPath.row]
                return cell
                
            default:
                return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension InfoViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = selectedRows[indexPath.section]
        
        switch section {
            case "Sexo":
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .checkmark
                    
                    if selectedGender.isEmpty {
                        selectedGender = indexPath
                    } else {
                        let deselectCell = tableView.cellForRow(at: selectedGender)
                        deselectCell?.isSelected = false
                        deselectCell?.accessoryType = .none
                        selectedGender = indexPath
                    }
                }
            
            case "Cámara":
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .camera
                imgPicker.allowsEditing = false
                imgPicker.showsCameraControls = true
                self.present(imgPicker, animated: true)
            
            case "Color Favorito":
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .checkmark
                }
            
            default:
                break
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = selectedRows[indexPath.section]
        
        switch section {
            case "Color Favorito":
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .none
                }
            
            default:
                break
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cells = selectedRows[indexPath.section]
        
        switch cells {
            case "Nombre Completo":
                return 100
            
            case "Número Telefónico":
                return 100
            
            case "Fecha de Nacimiento":
                return 100
            
            case "Sexo":
                return 60
            
            case "Cámara":
                return 180
                
            case "Foto":
                return 60

            case "Color Favorito":
                return 60
                
            default:
                return 0
        }
    }
}

//MARK: - UIImagePickerControllerDelegate
extension InfoViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let takenPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = takenPhoto
        }
        
        infoView.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
