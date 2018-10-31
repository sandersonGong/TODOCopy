//
//  Item.swift
//  TODOCopy
//
//  Created by 龚云飞 on 2018/10/31.
//  Copyright © 2018年 Sanderson. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory =  LinkingObjects(fromType: Category.self, property: "items")
}
