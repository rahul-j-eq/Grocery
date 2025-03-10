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
    
    //MARK: ITEM cellForItemAt
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
    
    //MARK: ITEM sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
    func updateCollectionViewHeight() {
        self.layoutIfNeeded()
        let height = itemCollectionView.contentSize.height
        collectionViewHeightConstraint.constant = height
    }
    
    //MARK: ITEM didSelectItemAt
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
    //MARK: DiscountItem cellForItemAt
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
    
    //MARK: DiscountItem sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
    func updateCollectionViewHeight() {
        self.layoutIfNeeded()
        let height = discountItemCV.contentSize.height
        self.collectionViewHeightConstraint.constant = height
    }
    
    //MARK: ITEM didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = sectionData?.items[indexPath.item] {
            delegate?.didSelectDicountItem(selectedItem)
        }
    }
}
