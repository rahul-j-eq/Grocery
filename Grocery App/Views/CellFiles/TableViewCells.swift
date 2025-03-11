//
//  HeaderTVCell.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit


protocol ItemTableViewCellDelegate: AnyObject {
    func didSelectItem(_ item: ItemType)
}

protocol DiscountItemTableViewCellDelegate: AnyObject {
    func didSelectDicountItem(_ item: ItemType)
}

protocol CategoryTableViewCellDelegate: AnyObject {
    func didSelectDetailItem(_ item: CategoryData)
}

// Helper function for setting up the UICollectionView
extension UITableViewCell {
    func setupCollectionView(_ collectionView: UICollectionView, delegate: UICollectionViewDelegate & UICollectionViewDataSource , direction : UICollectionView.ScrollDirection) {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = direction
        }
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
    }
}


//MARK: - Main TVCells
class HeaderTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var bagButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}



class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var sectionData: SectionData? {
        didSet {
            itemCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(self.itemCollectionView, delegate: self, direction: .vertical)
    }
} 

extension ItemTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCVCell", for: indexPath) as! ItemCVCell
        if case let .category(title, description) = sectionData?.items[indexPath.item] {
            cell.title.text = title
            cell.lblInfo.text = description
        }
        
        // Call configure to apply background color logic
        cell.configure(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
    func updateCollectionViewHeight() {
        self.layoutIfNeeded()
        let height = itemCollectionView.contentSize.height
        collectionViewHeightConstraint.constant = height
    }
    
    //MARK: ItemTableViewCellDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = sectionData?.items[indexPath.item] {
            delegate?.didSelectItem(selectedItem)
        }
    }
}

class DiscountItemTableViewCell: UITableViewCell {

    @IBOutlet weak var discountItemCV: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: DiscountItemTableViewCellDelegate?
    
    var sectionData: SectionData? {
        didSet {
            discountItemCV.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(self.discountItemCV, delegate: self, direction: .horizontal)
    }
    
}

extension DiscountItemTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountItemCVCell", for: indexPath) as! DiscountItemCVCell
        if case let .product(title, quantity, price) = sectionData?.items[indexPath.item] {
            cell.title.text = title
            cell.lblInfo.text = quantity
            cell.price.text = "\(price)$"
        }
        cell.configure(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
    func updateCollectionViewHeight() {
        self.layoutIfNeeded()
        let height = discountItemCV.contentSize.height
        self.collectionViewHeightConstraint.constant = height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = sectionData?.items[indexPath.item] {
            delegate?.didSelectDicountItem(selectedItem)
        }
    }
}


//MARK: - Category TVCells

class CategoryTVCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    var categoryDataList: [CategoryData] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(categoryCollectionView, delegate: self, direction: .vertical)
    }
    
    func configure(with data: [CategoryData]) { // Now accepts an array
        self.categoryDataList = data // Store the array
        categoryCollectionView.reloadData()
        updateCollectionViewHeight()
    }

}

extension CategoryTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as! CategoryCVCell
        
        let categoryItem = categoryDataList[indexPath.item]
        cell.title.text = categoryItem.title
        cell.infoLbl.text = "\(categoryItem.items.count) items"
        cell.configure(indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width/2)
    }
    
    func updateCollectionViewHeight() {
        self.layoutIfNeeded()
        let height = categoryCollectionView.contentSize.height
        self.collectionViewHeightConstraint.constant = height
    }
    
    //MARK: DetailsTableViewCellDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryDataList[indexPath.item] // Get the selected category
        print("Selected Category: \(selectedCategory.title)")
        delegate?.didSelectDetailItem(selectedCategory)
    }
}

//MARK: - Details TVCells

class ProductInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(description: String){
        self.lblDescription.text = description
    }
}

class PriceTableCell: UITableViewCell {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var products: [ProductItem] = []  // Store product data
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func configure(products: [ProductItem]) {
        self.products = products
        tableview.reloadData() // Refresh table when data is set
    }
}

extension PriceTableCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalItemsCell", for: indexPath) as! TotalItemsCell
        let product = products[indexPath.row]
        cell.configure(index: indexPath.row + 1, title: product.title, quantity: product.quantity, price: product.price)
        return cell
    }
}

class TotalItemsCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    func configure(index: Int, title: String, quantity: String, price: String) {
        indexLabel.text = "\(index)"
        nameLabel.text = title
        quantityLabel.text = quantity
    }
}


class CheckoutCell: UITableViewCell {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(totalPrice: String){
        
    }
}
