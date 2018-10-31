//
//  Category.swift
//  TODOCopy
//
//  Created by 龚云飞 on 2018/10/31.
//  Copyright © 2018年 Sanderson. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
    
}
