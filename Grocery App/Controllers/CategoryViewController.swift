//
//  CategoryViewController.swift
//  Grocery App
//
//  Created by Gaurav Patel on 10/03/25.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - TableView Data
    var categorySections: [CategorySectionType] = [
        .header,  // Section 0 - Header
        
        .categories(items: [  // Section 1 - Categories
            CategoryData(
                title: "Vegetables & Fruits",
                description: "Vegetables are parts of plants that are consumed by humans.",
                items: [.categoryItem(title: "Vegetables & Fruits")]
            ),
            CategoryData(
                title: "Bites & Drinks",
                description: "A variety of snacks and beverages to keep you refreshed.",
                items: [.categoryItem(title: "Bites & Drinks")]
            ),
            CategoryData(
                title: "Cooking & Elements",
                description: "Essential ingredients for delicious home-cooked meals.",
                items: [.categoryItem(title: "Cooking & Elements")]
            ),
            CategoryData(
                title: "Dairy Products",
                description: "Milk, cheese, yogurt, and other dairy essentials.",
                items: [.categoryItem(title: "Dairy Products")]
            ),
            CategoryData(
                title: "Bakery Items",
                description: "Freshly baked bread, pastries, and cakes for every occasion.",
                items: [
                    .categoryItem(title: "Bakery Items")
                ]
            ),
            CategoryData(
                title: "Transport & Vehicles",
                description: "Various transport options including cars, bikes, and logistics.",
                items: [.categoryItem(title: "Transport & Vehicles")]
            )
        ]),

        .rating  // Section 3 - Rating...
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

// MARK: - TableView Delegate & DataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorySections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch categorySections[section] {
        case .header:
            return nil
        case .categories:
            return "Explore All Categories"
        case .rating:
            return "Selected Items"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch categorySections[section] {
        case .header:
            return 1  // Discount cell
        case .categories(let items):
            print(items)
            return 1 // CollectionViewCell (Contains all categories)
        case .rating:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch categorySections[indexPath.section] {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath)
            return cell
            
        case .categories(let items):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell", for: indexPath) as! CategoryTVCell
            cell.delegate = self
            cell.configure(with: items) // Pass categories to the CollectionView
            return cell
            
        case .rating:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension CategoryViewController: CategoryTableViewCellDelegate{
    func didSelectDetailItem(_ item: CategoryData) {
        print(item)
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
