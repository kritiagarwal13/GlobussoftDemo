//
//  ImagePicker.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//


import Foundation
import UIKit
import Photos
import MobileCoreServices
protocol ImagePickerDelegate:class{
    func imagePicked(image:UIImage)
    func pickedImageName(image:UIImage,imageName:String)
}
class ImagePicker:UIImagePickerController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    weak var imageDelegate : ImagePickerDelegate?
    
    func openGallery()
    {
        self.allowsEditing = false
        self.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.mediaTypes = [(kUTTypePNG as String), (kUTTypeJPEG as String), (kUTTypeImage as String),(kUTTypeJPEG2000 as String)] // This is an array - you can add other format Strings as well

        Utilities.topViewController()?.present(self, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.allowsEditing = false
            self.sourceType = UIImagePickerController.SourceType.camera
            self.cameraCaptureMode = .photo
            Utilities.topViewController()?.present(self, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: k.kCameraNotFound, message: k.kDeviceWithNoCamera, preferredStyle: .alert)
            let ok = UIAlertAction(title: k.kOK, style:.default, handler: nil)
            alert.addAction(ok)
            Utilities.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        imageDelegate?.imagePicked(image: chosenImage)
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
            imageDelegate?.pickedImageName(image: chosenImage, imageName: assetResources.first!.originalFilename)
            print(assetResources.first!.originalFilename)
        }else{
            imageDelegate?.pickedImageName(image: chosenImage, imageName: "IMG_Captured.jpeg")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage()
    {
        self.delegate = self
        
        let actionSheetController: UIAlertController = UIAlertController(title: k.kUpload_Image, message: "", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: k.kCancel, style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        let takePictureAction: UIAlertAction = UIAlertAction(title:k.kTake_Picture, style: .default) { action -> Void in
            self.openCamera()
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: k.kChoose_Existing, style: .default) { action -> Void in
            self.openGallery()
        }
        actionSheetController.addAction(choosePictureAction)
        Utilities.topViewController()?.present(actionSheetController, animated: true, completion: nil)
    }
}




