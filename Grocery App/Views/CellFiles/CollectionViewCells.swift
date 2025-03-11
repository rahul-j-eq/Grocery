//
//  ItemCVCell.swift
//  Grocery App
//
//  Created by Gaurav Patel on 07/03/25.
//

import UIKit

//MARK: - MainVC Cells

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



//MARK: - Category Cells

class CategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(indexPath: IndexPath) {
        // Generate a random bright color
        let randomColor = [
            UIColor.systemRed,
            UIColor.systemBlue,
            UIColor.systemGreen,
            UIColor.systemYellow,
            UIColor.systemOrange,
            UIColor.systemPurple,
            UIColor.systemPink,
            UIColor.systemTeal,
            UIColor.systemIndigo,
            UIColor.systemBrown,
            UIColor.systemCyan,
            UIColor.systemMint,
            UIColor.red,
            UIColor.blue,
            UIColor.brown,
        ].randomElement() ?? UIColor.systemBlue
        
        // Apply 100% opacity to subView
        subView.backgroundColor = randomColor
        
        // Apply 30% opacity version of the color to mainView
        mainView.borderWidth = 1
        mainView.borderColor = randomColor
        mainView.backgroundColor = randomColor.withAlphaComponent(0.3)
    }

}
