//  AppDelegate.swift
//  DKDropDownView.swift
//
//  Created by dharmesh304 on 05/29/2021.
//  Copyright (c) 2021 dharmesh304. All rights reserved.
//

import UIKit

extension UITextField {
    public func setDropDown(delegate:DropDowndelegate , array : [[String]]) {
        var bundle = Bundle(for: DKDropDownView.self)
        if let resourcePath = bundle.path(forResource: "DKDropDownView", ofType: "bundle") {
            if let resourcesBundle = Bundle(path: resourcePath) {
                bundle = resourcesBundle
            }
        }
        let dropDownView = bundle.loadNibNamed("DKDropDownView", owner: nil, options: nil)?[0] as! DKDropDownView
        dropDownView.datePicker.isHidden = true
        dropDownView.pickerView.isHidden = false
        dropDownView.delegate = delegate
        dropDownView.input = array
        dropDownView.textfield = self
        self.tintColor = UIColor.clear
        self.inputView = dropDownView
    }
    
    public func setDatePicker(delegate:DropDowndelegate,formatte:String,datePickerMode:UIDatePicker.Mode,date:Date? = nil ,max:Date? = nil ,min:Date? = nil ) {
        var bundle = Bundle(for: DKDropDownView.self)
        if let resourcePath = bundle.path(forResource: "DKDropDownView", ofType: "bundle") {
            if let resourcesBundle = Bundle(path: resourcePath) {
                bundle = resourcesBundle
            }
        }
        
        
        let dropDownView = bundle.loadNibNamed("DKDropDownView", owner: nil, options: nil)?[0] as! DKDropDownView
        dropDownView.datePicker.isHidden = false
        dropDownView.pickerView.isHidden = true
        dropDownView.datePicker.maximumDate = max
        dropDownView.datePicker.minimumDate = min
        if let dt = date {
            dropDownView.datePicker.date = dt
        }
        dropDownView.datePicker.datePickerMode = datePickerMode
        dropDownView.formate = formatte
        dropDownView.delegate = delegate
        dropDownView.textfield = self
        if #available(iOS 13.4, *) {
            dropDownView.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        self.tintColor = UIColor.clear
        self.inputView = dropDownView
    }
}

@objc public protocol DropDowndelegate {
    @objc optional func pickerDidPressDone(textField:UITextField, data:[PickerValue])
    @objc optional func pickerDidPressDone(textField:UITextField, date:Date)
    @objc optional func pickerDidPressCancle(textField:UITextField)
}

@objc public class PickerValue : NSObject {
    public var value:String = ""
    public var index:Int = 0
    
    required init(value:String,index:Int) {
        super.init()
        self.value = value
        self.index = index
    }
}

class DKDropDownView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    var delegate:DropDowndelegate?
    public var input:[[String]]! = [[String]]()
    public var textfield:UITextField!
    private var selectedValue:String = ""
    fileprivate var formate:String? = "yyyy-MM-dd"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
//        self.datePicker.addTarget(self, action: #selector(datePickerValueChange(_:)), for: .valueChanged)
    }
    
//    func datePickerValueChange(_ sender:Any) {
//        
//        
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return input.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return input[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return input[component][row]
//        Array.object(at: row) as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedValue = input[component][row]
        //selectedValue = (inputArray.object(at: row) as? String)!
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        textfield.resignFirstResponder()
        
        if !self.datePicker.isHidden {
            textfield.resignFirstResponder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formate
            
            textfield.text = dateFormatter.string(from: self.datePicker.date)
            if let delegate = self.delegate {
                delegate.pickerDidPressDone!(textField: textfield, date: self.datePicker.date)
            }
            else {
                assert(self.delegate == nil, "Must be implement pickerDidPressDone(textField:UITextField, date:Date)")
            }
        }
        
        if !self.pickerView.isHidden {
            var items:[PickerValue] = []
            for i in 0...(self.input.count - 1) {
                let intVal = self.pickerView.selectedRow(inComponent: i)
                let val = input[i][intVal]
                textfield.accessibilityValue = "\(i)-\(intVal)"
                let pickerVal = PickerValue(value: val, index: intVal)
                items.append(pickerVal)
            }
            if let delegate = self.delegate {
                delegate.pickerDidPressDone!(textField: textfield!, data: items)
            }
            else {
                assert(self.delegate == nil, "Must be implement pickerDidPressDone(textField:UITextField, data:[PickerValue])")
            }
        }
    }
    @IBAction func btnCancleAction(_ sender: Any) {
        textfield.resignFirstResponder()
        self.delegate?.pickerDidPressCancle!(textField: textfield)
    }
}
