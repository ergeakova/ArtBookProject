//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Erge Gevher Akova on 27.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Art Book"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVc", sender: nil)
    }
}
