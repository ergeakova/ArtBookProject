//
//  DetailsVc.swift
//  ArtBookProject
//
//  Created by Erge Gevher Akova on 27.04.2022.
//

import UIKit
import CoreData

class DetailsVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide Keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
        view.addGestureRecognizer(gestureRecognizer)
        
        //Add image
        imageView.isUserInteractionEnabled = true
        let imageTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTabRecognizer)
    }
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func hideKeybord(){
        view.endEditing(true)
    }
    
    @IBAction func imageSave(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(UUID(), forKey: "id")
        newPainting.setValue(txtName.text!, forKey: "name")
        newPainting.setValue(txtArtist.text!, forKey: "artist")
        if let year = Int(txtYear.text!){
            newPainting.setValue(year, forKey: "year")
        }
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        
        do{
            try context.save()
            print("success")
        } catch{
            print("error")
        }
        
        
    }
}
