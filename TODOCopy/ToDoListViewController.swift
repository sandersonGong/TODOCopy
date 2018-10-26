//
//  ViewController.swift
//  TODOCopy
//
//  Created by 龚云飞 on 2018/10/25.
//  Copyright © 2018年 Sanderson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //在应用运行期间，维持各种数据，采用键值对的形式支持多种数据类型
//    let defaults = UserDefaults.standard
    //在指定目录下创建一个储存数据的文件
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    //演示数组
    var itemArray = [Item]()
    
    
    
    //视图载入函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //如果键值对存在，就把值赋值给items 并把items赋值给itemArray
        //创建常量储存应用的Document文件路径
        
        loadItems()
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//
//        let  newItem = Item()
//        newItem.title = "购买水杯"
//        itemArray.append(newItem)
//        let  newItem1 = Item()
//        newItem1.title = "水杯"
//        itemArray.append(newItem1)
//        let  newItem2 = Item()
//        newItem2.title = "水杯"
//        itemArray.append(newItem2)
//        }
        
    }
    
    //添加按钮触发方法
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //创建一个输入框变量 方便后期调用
        var textField = UITextField()
        
        //创建弹窗样式及内容
        let alert = UIAlertController(title: "添加一个新项目", message: "", preferredStyle: .alert)
        
        //弹窗内添加输入框
        alert.addTextField{ (alertTextFeild) in
            //弹窗输入框提示
            alertTextFeild.placeholder = "填写项目内容..."
            //将设置的输入框赋值到外面的变量，方便传递
            textField = alertTextFeild
        }
        
        //创建弹窗按钮及方法
        let action = UIAlertAction(title: "添加项目", style: .default){(action) in
            let newItem = Item()
            newItem.title = textField.text!
            //在记事数组中添加事件内容
            self.itemArray.append(newItem)
            //创建PropertyListEncoder实例，通过其encode方法将items类型数组编码为plist格式
            self.saveItems()
            //设置用户储存的键值对信息，值 键
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //重新载入列表数据
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //设置列表视图单元格显示内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
//        if itemArray[indexPath.row].done == false {
//            cell.accessoryType = .none
//        }else{
//            cell.accessoryType = .checkmark
//        }
        
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //返回列表视图单元格个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //点击勾选或点击取消勾选，点击执行高亮动画
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else{
//             itemArray[indexPath.row].done = false
//        }
  
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)

        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
     
        self.saveItems()
       
        
    }
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("编码错误：\(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("解码item错误")
            }
            
        }
    }
    
}

