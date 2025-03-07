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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
}

class DiscountItemTableViewCell: UITableViewCell {

    @IBOutlet weak var discountItemCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        discountItemCV.delegate = self
        discountItemCV.dataSource = self
    }
    
}

extension DiscountItemTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscountItemCVCell", for: indexPath) as! DiscountItemCVCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 2
        return CGSize(width: width, height: width)
    }
    
}
