//
//  TodoDetailsVC.swift
//  TodolistAPP
//
//  Created by Venkatesh K on Saka 1940-09-14.
//  Copyright © 1940 Saka Venkatesh K. All rights reserved.
//

import UIKit
import CoreData

class TodoDetailsVC: UIViewController, UITextFieldDelegate {
    var getObjectValues : NSManagedObject?
    @IBOutlet weak var textViewTaskNotes: UITextView!
    @IBOutlet weak var textViewTaskName: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    
    var textFieldSelected : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        self.navigationItem.title = "ToDo Item Details"
        textViewTaskName.text = getObjectValues?.value(forKey: "name") as? String
        textViewTaskNotes.text = getObjectValues?.value(forKey: "notes") as? String
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func updateButtonPressed(_ sender: Any) {
        let  context = appDelegate.persistentContainer.viewContext
        _ = NSEntityDescription.entity(forEntityName: "Todo", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        textFieldSelected?.resignFirstResponder()
        fetchRequest.predicate = NSPredicate(format: "name = %@", getObjectValues?.value(forKey: "name") as? String ?? "")
        do{
            let gettingObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            let objValues = gettingObject[0]
            objValues.setValue(getObjectValues?.value(forKey: "completed"), forKey: "completed")
            objValues.setValue(textViewTaskName.text!, forKey: "name")
            objValues.setValue(textViewTaskNotes.text!, forKey: "notes")
            do{
                try context.save()
                self.navigationController?.popViewController(animated: true)
            }catch{
                
            }
        }catch {
            
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        textFieldSelected?.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let  context = appDelegate.persistentContainer.viewContext
        _ = NSEntityDescription.entity(forEntityName: "Todo", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        textFieldSelected?.resignFirstResponder()
        fetchRequest.predicate = NSPredicate(format: "name = %@", getObjectValues?.value(forKey: "name") as? String ?? "")
        do{
            let gettingObject = try context.fetch(fetchRequest) as! [NSManagedObject]
            let gettIngData = gettingObject[0]
            
                context.delete(gettIngData)
                do{
                    try context.save()
                    self.navigationController?.popViewController(animated: true)
                }catch{
                    
                }
                self.navigationController?.popViewController(animated: true)
            
            
        }catch {
            
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldSelected = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

