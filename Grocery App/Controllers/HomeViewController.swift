//
//  ViewController.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewData: [SectionData] = [
        // Header Section
        SectionData(
            title: "Header",
            items: [
                .header(address: "100 High Street, London")
            ]
        ),
        
        // Explore Categories Section
        SectionData(
            title: "Explore Categories",
            items: [
                .category(title: "Vegetables", description: "Vegetables are parts of plants that are consumed by humans..."),
                .category(title: "Fish & Meat", description: "Fish is the flesh of an animal used for food, and by that definition...")
            ]
        ),

        // For Sale and Low Cost Section
        SectionData(
            title: "For Sale and Low Cost",
            items: [
                .product(title: "Washing Liquid", quantity: "220 ml", price: "$230"),
                .product(title: "Coffee and Tea", quantity: "100 g", price: "$30")
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        setupTableHeaderView()
    }
    
    func setupTableHeaderView() {
        if let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderTVCell") as? HeaderTVCell {
            tableView.tableHeaderView = headerView
            tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150) // Adjust height as needed
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section contains a single row
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = tableViewData[indexPath.section] // Get section data

        switch sectionData.items.first {  // Check first item type
        case .header(let address):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVCell", for: indexPath) as! HeaderTVCell
            cell.addressLabel.text = address
            return cell
            
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            // Pass section data if needed (e.g., to collectionView inside the cell)
            return cell
            
        case .product:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountItemTableViewCell", for: indexPath) as! DiscountItemTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionData = tableViewData[indexPath.section]

        switch sectionData.items.first {
        case .header:
            return UITableView.automaticDimension // Adjust header height as needed
        case .category, .product:
            return 400 // Height for collectionView cells
        default:
            return UITableView.automaticDimension // Adjust dynamically for other cells
        }
    }
}
