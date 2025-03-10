//
//  HeaderTVCell.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

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
    
    var sectionData: SectionData? {
        didSet {
            itemCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
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
    
}

class DiscountItemTableViewCell: UITableViewCell {

    @IBOutlet weak var discountItemCV: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    var sectionData: SectionData? {
        didSet {
            discountItemCV.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        discountItemCV.delegate = self
        discountItemCV.dataSource = self
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
    
}
