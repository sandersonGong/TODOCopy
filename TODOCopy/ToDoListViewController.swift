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
    let defaults = UserDefaults.standard
    //演示数组
    var itemArray = ["购买水杯","吃药","修改密码"]
    
    //视图载入函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //如果键值对存在，就把值赋值给items 并把items赋值给itemArray
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
        
    }
    
    //添加按钮触发方法
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //创建一个输入框变量 方便后期调用
        var textField = UITextField()
        
        //创建弹窗样式及内容
        let alert = UIAlertController(title: "添加一个新项目", message: "", preferredStyle: .alert)
        //创建弹窗按钮及方法
        let action = UIAlertAction(title: "添加项目", style: .default){(action) in
            //在记事数组中添加事件内容
            self.itemArray.append(textField.text!)
            //设置用户储存的键值对信息，值 键
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //重新载入列表数据
            self.tableView.reloadData()
            
            
        }
        
        //弹窗内添加输入框
        alert.addTextField{(alertTextFeild) in
            //弹窗输入框提示
            alertTextFeild.placeholder = "创建一个新项目..."
            //将设置的输入框赋值到外面的变量，方便传递
            textField = alertTextFeild
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //设置列表视图单元格显示内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //返回列表视图单元格个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //点击勾选或点击取消勾选，点击执行高亮动画
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
//      tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

