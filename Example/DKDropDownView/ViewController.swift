//
//  ViewController.swift
//  DKDropDownView
//
//  Created by dharmesh304 on 05/29/2021.
//  Copyright (c) 2021 dharmesh304. All rights reserved.
//

import UIKit
import DKDropDownView

class ViewController: UIViewController {

    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var txtPicker: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Datepicker
        self.txtDatePicker.setDatePicker(delegate: self, formatte: "DD-MM-YYYY", datePickerMode: .date)
        
        //Setup for custo picker
        
        let name = ["Dharmesh","Jaydeep","Kavya","Pihu"]
        let courtesy_titles = ["Mr.","Mrs.", "Ms.","Dr."]
        self.txtPicker.setDropDown(delegate: self, array: [courtesy_titles,name])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : DropDowndelegate {
    func pickerDidPressDone(textField: UITextField, date: Date) {
        print("Selected Date ==>",date)
    }
    
    func pickerDidPressDone(textField: UITextField, data: [PickerValue]) {
        textField.text = data.compactMap({$0.value}).joined(separator: " ")
    }
    
    func pickerDidPressCancle(textField: UITextField) {
        
    }
}
