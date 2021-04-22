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
    @IBOutlet weak var lblAddImg: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    //MARK:- Properties
    var imagePicker : ImagePicker?
    var pickedImage : UIImage?
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    
    //MARK:- Extra methods
    func initialSetup() {
        nameDOB.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.imgVw.roundCornerWithShadow(shadowColor: .lightGray, radius: self.imgVw.frame.height/2, borderWidth: 0, borderColor: .clear, shadowOpacity: 2, shadowRadius: 2, shadowOffsetWidth: 2, shadowOffsetHeight: 2, clipsbounds: true)
        self.btnRegister.roundCornerWithShadow(shadowColor: .lightGray, radius: 10, borderWidth: 1, borderColor: .link, shadowOpacity: 1, shadowRadius: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        
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
        
        UserSessionManager.shared.setName(value: nameTF.text)
        UserSessionManager.shared.setDOB(value: nameDOB.text)
        UserSessionManager.shared.setGender(value: genderTF.text)
        UserSessionManager.shared.setAvatar(image: pickedImage)
        UserSessionManager.shared.setIsRegistered(value: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigateToVC()
        
    }
    
    @IBAction func imgVwTapped(_ sender: UIButton) {
        imagePicker = ImagePicker()
        imagePicker?.imageDelegate = self
        imagePicker?.uploadImage()
    }
    
    
}


extension ViewController : ImagePickerDelegate {
    func imagePicked(image: UIImage) {
        self.lblAddImg.isHidden = true
        self.imgVw.image = image
    }
    
    func pickedImageName(image: UIImage, imageName: String) {
        self.pickedImage = image
        print(imageName)
    }
    
    
}
