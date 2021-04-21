//
//  ViewController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 15/04/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- @IBOutlets
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameDOB: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    
    //MARK:- Properties
    
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDOB.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    }

    
    //MARK:- Extra methods
    func initialSetup() {
        
        
        
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.nameDOB.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.nameDOB.text = dateFormatter.string(from: datePicker.date)
        }
        self.nameDOB.resignFirstResponder()
    }
    
    
    //MARK:- @IBActions
    @IBAction func registerTapped(_ sender: UIButton) {
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func imgVwTapped(_ sender: UIButton) {
        
    }
    
    
}

extension UITextField {

   func addInputViewDatePicker(target: Any, selector: Selector) {

    let screenWidth = UIScreen.main.bounds.width

    //Add DatePicker as inputView
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
    self.inputView = datePicker

    //Add Tool Bar as input AccessoryView
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
    let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

    self.inputAccessoryView = toolBar
 }

   @objc func cancelPressed() {
     self.resignFirstResponder()
   }
}
