//
//  PickerView.swift
//
//  Created by Kriti on 23/11/18.
//  Copyright © 2018 Kriti. All rights reserved.
//

import UIKit

protocol PickerViewDelegate : class {
    func doneTapped(value:String,index : Int?)
    func cancelTapped()
}

class PickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    weak var delegate : PickerViewDelegate?
    @IBOutlet weak var pickerBGView: UIView!
    @IBOutlet weak var pickerTitle: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pickerBottomConstraint: NSLayoutConstraint!
    
    var pickerArr = [""]
    var selectedValue = ""
    var selectedIndex : Int?
    var currentSelection = 0
    override func awakeFromNib() {
       
    }
    
    class func instanceFromNib() -> PickerView
    {
        let view = UINib(nibName: "PickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PickerView
        return view
    }
    
    
    func setdata(arr:[String]?,pickerTitle:String?,currentSelection : Int? = 0){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        selectedValue = arr?[((currentSelection ?? 0) == -1) ? 0 : (currentSelection ?? 0)] ?? ""
        pickerBottomConstraint.constant = -self.pickerBGView.frame.size.height
        pickerArr = arr ?? [""]
        self.pickerTitle.text = pickerTitle ?? ""
        pickerView.selectRow(currentSelection ?? 0, inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
    }
    
    func showPicker() {
         self.pickerBottomConstraint.constant = -self.pickerBGView.frame.size.height
         self.layoutIfNeeded()
        UIView.animate(withDuration: Double(0.5), animations: {
            self.pickerBottomConstraint.constant = 0
            self.layoutIfNeeded()
        }) { (success) in
           
        }
    }
    
    func hidePicker() {
        self.pickerBottomConstraint.constant = 0
        self.layoutIfNeeded()
        UIView.animate(withDuration: Double(0.5), animations: {
            self.pickerBottomConstraint.constant = -self.pickerBGView.frame.size.height
            self.layoutIfNeeded()
        }) { (success) in
            self.removeFromSuperview()
           
        }
    }
    
    //MARK: -----Picker Delegates and Datasource-----
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return pickerArr.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = pickerArr[row]
        selectedIndex = row
    }
    
    
    
    //MARK: ------IBAction-------

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        hidePicker()
        self.delegate?.cancelTapped()
        self.removeFromSuperview()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        hidePicker()
        self.delegate?.doneTapped(value: selectedValue.replacingOccurrences(of: " lbs", with: "").replacingOccurrences(of: " yrs", with: ""),index: selectedIndex)
    }
    
}
