//
//  ViewController.swift
//  TodolistAPP
//
//  Created by Venkatesh K on Saka 1940-09-14.
//  Copyright © 1940 Saka Venkatesh K. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext?
    var entity : NSEntityDescription?
    
    var aryValues : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Todo", in: context!)
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "isLoaded") != false {
            let todoEntity = Todo(context : context!)
            todoEntity.completed = true
            todoEntity.name = "Add name/notes here"
            todoEntity.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity2 = Todo(context : context!)
            todoEntity2.completed = false
            todoEntity2.name = "Add name/notes here"
            todoEntity2.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity3 = Todo(context : context!)
            todoEntity3.completed = false
            todoEntity3.name = "Add name/notes here"
            todoEntity3.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity4 = Todo(context : context!)
            todoEntity4.completed = true
            todoEntity4.name = "ToDoList4 App"
            todoEntity4.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity5 = Todo(context : context!)
            todoEntity5.completed = false
            todoEntity5.name = "ToDoList5 App"
            todoEntity5.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity6 = Todo(context : context!)
            todoEntity6.completed = true
            todoEntity6.name = "ToDoList6 App"
            todoEntity6.notes = "This page has two pages one is ToDo List page & another one is detials page"
            
            let todoEntity7 = Todo(context : context!)
            todoEntity7.completed = true
            todoEntity7.name = "ToDoList7 App"
            todoEntity7.notes = "Add notes here"
            do {
                try context?.save()
                userDefaults.set(true, forKey: "isLoaded")
                userDefaults.synchronize()
            } catch  {
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            let results =  try context?.fetch(fetchRequest)
            aryValues.removeAll()
            for eachData in results as! [NSManagedObject] {
                // print(eachData.value(forKey: "name") ?? "")
                aryValues.append(eachData)
            }
            tableView.reloadData()
        } catch  {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryValues.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList") as! ToDoListTableViewCell
        let getValues = aryValues[indexPath.row]
        cell.lblTask.text = getValues.value(forKey: "name") as? String
        cell.switchStatus.isOn = getValues.value(forKey: "completed") as! Bool
        cell.switchStatus.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func editButtonPressed(_ sender: Any) {
        print((sender as! UIButton).tag)
        
        let getValues = aryValues[(sender as! UIButton).tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TodoDetails") as! TodoDetailsVC
        controller.getObjectValues = getValues
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func taskStatusChanged(_ sender: UISwitch) {
        let getValues = aryValues[sender.tag]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", getValues.value(forKey: "name") as? String ?? "")
        do{
            let gettingObject = try context?.fetch(fetchRequest)
            let objValues = gettingObject?[0] as! NSManagedObject
            objValues.setValue(sender.isOn, forKey: "completed")
            objValues.setValue(getValues.value(forKey: "name"), forKey: "name")
            objValues.setValue(getValues.value(forKey: "notes"), forKey: "notes")
            do{
                try context?.save()
            }catch{
                
            }
        }catch {
            
        }
    }
}
