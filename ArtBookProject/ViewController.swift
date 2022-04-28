//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Erge Gevher Akova on 27.04.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPainting = ""
    var selectedPaintingID = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Art Book"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        tableView.dataSource = self
        tableView.delegate = self
        getdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getdata), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getdata() {
        nameArray.removeAll()
        idArray.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context?.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    self.idArray.append(id)
                }
                
                self.tableView.reloadData()
            }
        }catch{
            print("error")
        }
    }
    
    @objc func addButtonClicked() {
        selectedPainting = ""
        
        performSegue(withIdentifier: "toDetailsVc", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVc" {
            let destinationVC = segue.destination as! DetailsVc
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingID = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVc", sender: nil)
    }
}
