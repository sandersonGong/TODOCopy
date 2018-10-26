//
//  CategoryViewController.swift
//  TODOCopy
//
//  Created by 龚云飞 on 2018/10/26.
//  Copyright © 2018年 Sanderson. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
   
        let alert = UIAlertController(title: "添加新类别", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加", style: .default) {(action) in
            let newCateory = Category(context: self.context)
            newCateory.name = textField.text!
            self.categories.append(newCateory)
            self.saveCategories()
        }

        alert.addAction(action)

        alert.addTextField{ (field) in
            field.placeholder = "添加一个新的类别"
            textField = field
        }

         present(alert, animated: true, completion: nil)

        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier : "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if segue.identifier == "goToItems" {
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        }
    }
    
    func saveCategories(){
        do {
            try context.save()
        }catch{
            print("保存错误：\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        }catch{
            print("载入失败，\(error)")
        }
        
        tableView.reloadData()
        
    }

}
