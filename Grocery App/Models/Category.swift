//
//  ItemModel.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

// MARK: - Enum for Section Type
enum CategorySectionType {
    case header
    case categories(items: [CategoryData]) // Stores categories
    case rating
}

// MARK: - Category Model
enum CategoryType {
    case categoryItem(title: String)
}

// Data structure for categories
struct CategoryData {
    let title: String
    let description: String
    let items: [CategoryType]
}
