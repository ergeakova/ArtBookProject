//
//  DetailsVc.swift
//  ArtBookProject
//
//  Created by Erge Gevher Akova on 27.04.2022.
//

import UIKit

class DetailsVc: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblArtist: UITextField!
    @IBOutlet weak var lblYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
      
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeybord(){
        view.endEditing(true)
    }
    
    @IBAction func imageSave(_ sender: Any) {
        
    }
}
