//
//  ItemModel.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

enum ItemType {
    case header(address: String)  // For the Header Cell
    case category(title: String, description: String)  // For "Explore Categories"
    case product(title: String, quantity: String, price: String)  // For "For Sale and Low Cost"
}

struct SectionData {
    let title: String
    let items: [ItemType]
}
