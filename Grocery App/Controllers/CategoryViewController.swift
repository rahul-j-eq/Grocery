//
//  CategoryViewController.swift
//  Grocery App
//
//  Created by Gaurav Patel on 10/03/25.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let categoryList: [CategoryData] = [
        CategoryData(
            title: "Vegetables",
            description: "Vegetables are parts of plants that are consumed by humans.",
            items: [.categoryItem(title: "Vegetables", totalItems: 50)]
        ),
        CategoryData(
            title: "Fruits",
            description: "Fruits are nature's sweet and nutritious treats, rich in vitamins.",
            items: [.categoryItem(title: "Fruits", totalItems: 28)]
        ),
        CategoryData(
            title: "Fish & Meat",
            description: "Fresh fish and meat products sourced from quality vendors.",
            items: [.categoryItem(title: "Fish & Meat", totalItems: 15)]
        ),
        CategoryData(
            title: "Dairy Products",
            description: "Milk, cheese, yogurt, and other dairy essentials.",
            items: [.categoryItem(title: "Dairy Products", totalItems: 20)]
        ),
        CategoryData(
            title: "Bakery Items",
            description: "Freshly baked bread, pastries, and cakes for every occasion.",
            items: [.categoryItem(title: "Bakery Items", totalItems: 17)]
        ),
        CategoryData(
            title: "Beverages",
            description: "A collection of refreshing drinks including tea, coffee, and juices.",
            items: [.categoryItem(title: "Beverages", totalItems: 19)]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1  // One section for all categories
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Explore Categories" : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2  // Cell 0 = Header, Cell 1 = CollectionView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // Header Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
            
        case 1:
            // Category CollectionView Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell", for: indexPath) as! CategoryTVCell
            cell.configure(with: categoryList)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
