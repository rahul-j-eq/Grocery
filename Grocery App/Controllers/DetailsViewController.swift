//
//  DetailsViewController.swift
//  Grocery App
//
//  Created by Gaurav Patel on 11/03/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewData: [SectionData] = [
            SectionData(title: "", items: [.discount]), // Discount Cell
            SectionData(title: "", items: [.productImage]), // Image Cell
            SectionData(title: "Product Information", items: [
                .info(description: "vegetable, in the broadest sense, any kind of plant life or plant product, namely “vegetable matter”; in common, narrow usage, the term vegetable usually refers to the fresh edible portions of certain herbaceous plants—roots, stems, leaves, flowers, fruit, or seeds. These plant parts are either eaten fresh or prepared in a number of ways, usually as a savory, rather than sweet, dish.") ,
                .info(description: "vegetable, in the broadest sense, any kind of plant life or plant product, namely “vegetable matter”; in common, narrow usage, the term vegetable usually refers to the fresh edible portions of certain herbaceous plants—roots, stems, leaves, flowers, fruit, or seeds. These plant parts are either eaten fresh or prepared in a number of ways, usually as a savory, rather than sweet, dish.")
            ]), // Product Info Cell
            SectionData(title: "Price List", items: [
                .product(title: "Apple", quantity: "50", price: "200$"),
                .product(title: "Beans", quantity: "8", price: "27$")
            ]), // Price Table Cell
            SectionData(title: "", items: [
                .checkout(totalPrice: "227$")
            ]) // Checkout Footer Cell
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

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionData = tableViewData[section]
        return sectionData.title.isEmpty ? nil : sectionData.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tableViewData[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch item {
        case .discount:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath)
            return cell
            
        case .productImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductImageCell", for: indexPath)
            return cell
            
        case .info(let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell", for: indexPath) as! ProductInfoCell
            cell.configure(description: description)
            return cell
            
        case .product:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableCell", for: indexPath) as! PriceTableCell
            let products = section.items.compactMap { item -> ProductItem? in
                if case let .product(title, quantity, price) = item {
                    return ProductItem(title: title, quantity: quantity, price: price)
                }
                return nil
            }
            cell.configure(products: products)
            return cell
            
        case .checkout(let totalPrice):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
            cell.configure(totalPrice: totalPrice)
            return cell
            
        default : return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

