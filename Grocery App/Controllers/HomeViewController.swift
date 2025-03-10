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
            title: "",
            items: [
                .header(address: "100 High Street, Ahmedabad")
            ]
        ),
        
        // Explore Categories Section
        SectionData(
            title: "Explore Categories",
            items: [
                .category(title: "Vegetables", description: "Vegetables are parts of plants that are consumed by humans..."),
                .category(title: "Fish & Meat", description: "Fish is the flesh of an animal used for food, and by that definition..."),
                .category(title: "Vegetables", description: "Vegetables are parts of plants that are consumed by humans..."),
                .category(title: "Fish & Meat", description: "Fish is the flesh of an animal used for food, and by that definition...")
            ]
        ),

        // For Sale and Low Cost Section
        SectionData(
            title: "For Sale and Low Cost",
            items: [
                .product(title: "Washing Liquid", quantity: "220 ml", price: "230"),
                .product(title: "Coffee and Tea", quantity: "100 g", price: "30"),
                .product(title: "Washing Liquid", quantity: "220 ml", price: "68"),
                .product(title: "Coffee and Tea", quantity: "100 g", price: "37")
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }
    
    func setupTV(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
            cell.sectionData = sectionData
            cell.itemCollectionView.reloadData()
            cell.delegate = self
            // Update collectionView height after content loads
            DispatchQueue.main.async {
                cell.updateCollectionViewHeight()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            return cell
            
        case .product:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountItemTableViewCell", for: indexPath) as! DiscountItemTableViewCell
            cell.sectionData = sectionData
            cell.discountItemCV.reloadData()
            cell.delegate = self
            // Update collectionView height after content loads
            DispatchQueue.main.async {
                cell.updateCollectionViewHeight()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
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
            return UITableView.automaticDimension // Height for collectionView cells
        default:
            return UITableView.automaticDimension // Adjust dynamically for other cells
        }
    }
}


//MARK: - ItemTableViewCellDelegate
extension HomeViewController: ItemTableViewCellDelegate {
    func didSelectItem(_ item: ItemType) {
        switch item {
        case .category(let title, _ ):
            print("Category Selected: \(title)")
        case .product(let title, _, let price):
            print("Product Selected: \(title) - \(price)$")
        default:
            break
        }
    }
}

//MARK: - DiscountItemTableViewCellDelegate
extension HomeViewController: DiscountItemTableViewCellDelegate {
    func didSelectDicountItem(_ item: ItemType) {
        switch item {
        case .category(let title, _ ):
            print("Category Selected: \(title)")
        case .product(let title, _, let price):
            print("Product Selected: \(title) - \(price)$")
        default:
            break
        }
    }
}
