//
//  ItemCVCell.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

class ItemCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

class DiscountItemCVCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var BtnAddToCart: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
