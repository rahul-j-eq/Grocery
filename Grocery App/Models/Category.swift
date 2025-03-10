//
//  ItemModel.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

enum CategoryType {
    case categoryItem(title: String, totalItems: Int)
}

// Data structure for categories
struct CategoryData {
    let title: String
    let description: String
    let items: [CategoryType] // Stores category items
}
