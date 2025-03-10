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
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(indexPath: IndexPath) {
        let isPurple = (indexPath.item % 4 < 2)
        
        mainView.backgroundColor = isPurple ? UIColor.systemPurple : UIColor.yellow
        subView.backgroundColor = isPurple ? UIColor.systemGreen : UIColor.systemOrange
        
        let textColor: UIColor = isPurple ? .white : .black
        title.textColor = textColor
        lblInfo.textColor = textColor
    }
}

class DiscountItemCVCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var BtnAddToCart: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(indexPath: IndexPath) {
        let isRed = (indexPath.item % 4 < 2)
        
        mainView.backgroundColor = isRed ? UIColor.systemRed : UIColor.yellow
        subView.backgroundColor = isRed ? UIColor.systemOrange : UIColor.systemGreen
        
        let textColor: UIColor = isRed ? .white : .black
        title.textColor = textColor
        lblInfo.textColor = textColor
    }
}
