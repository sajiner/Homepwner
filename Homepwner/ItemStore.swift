//
//  ItemStore.swift
//  Homepwner
//
//  Created by sajiner on 2017/11/8.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            creatItem()
        }
    }
    
   @discardableResult func creatItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
}
