//
//  InputViewController.swift
//  ToDoListOfTDD
//
//  Created by 편성경 on 2023/06/08.
//

import UIKit

class InputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var mainVC: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Save Button Tapped
    @IBAction func doSave(_ sender: UIButton) {
        guard let titleString = titleTextField.text, titleString.count > 0 else {
            return
        }
        
        guard let locationString = locationTextField.text, locationString.count > 0 else {
            return
        }
        
        guard let descriptionString = descriptionTextField.text, descriptionString.count > 0 else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let formattedDate = dateFormatter.string(from: datePicker.date)
        
        let inputData = Model(title: titleString, location: locationString, description: descriptionString, time: formattedDate)
        
        mainVC.data.append(inputData)
        mainVC.data.sort(by: { $0.time < $1.time }) // 날짜 순서대로 정렬
        mainVC.tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    // MARK: - Cancel Button Tapped
    @IBAction func doCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}
