//
//  ViewController.swift
//  LearnLocalStorage
//
//  Created by Ilyasa Azmi on 04/07/19.
//  Copyright © 2019 co.ilyasa.azmi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let text = UserDefaults.standard.string(forKey: "name")
//        nameLabel.text = text
//        nameLabel.text = ""
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        var users = [User]()
        
        do {
            users = try managedContext.fetch(User.fetchRequest())
            
            for user in users {
                let name = user.value(forKey: "name") as! String
                nameLabel.text! += "\(name),"
                print(name)
            }
        } catch {
            print("Error")
        }
        
        
    }

    @IBAction func save(_ sender: UIButton) {
//        nameLabel.text = textField.text
//        UserDefaults.standard.set(nameLabel.text, forKey: "name")
        
        //save using core data
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let user = User(context: managedContext)
        user.name = textField.text
        
        do {
            try managedContext.save()
            print("Saved")
        } catch {
            print("Error")
        }
        
    }
    
    
}

