//
//  lunchCollectionViewCell.swift
//  Bing
//
//  Created by Vivek Guntuku on 30/04/25.
//

import UIKit

class lunchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lunchStackView: UIStackView!
    
    @IBOutlet weak var lunchImgView: UIImageView!
    
    @IBOutlet weak var lunchLabel: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    private var item: BreakfastItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
           // Cell appearance
           contentView.layer.cornerRadius = 8
           contentView.layer.masksToBounds = true
           contentView.backgroundColor = .systemBackground
           
           // Add shadow to the cell
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 2)
           layer.shadowRadius = 4
           layer.shadowOpacity = 0.1
           layer.masksToBounds = false
           
           // Image view setup
        lunchImgView.contentMode = .scaleAspectFill
        lunchImgView.clipsToBounds = true
        lunchImgView.layer.cornerRadius = 6
           
           // Name label setup
        lunchLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        lunchLabel.adjustsFontForContentSizeCategory = true
        lunchLabel.textColor = .label
        lunchLabel.numberOfLines = 2
           
           // Button setup
        addBtn.backgroundColor = .systemBlue
        addBtn.layer.cornerRadius = 6
        addBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        addBtn.titleLabel?.adjustsFontForContentSizeCategory = true
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.setTitle("Add to Cart", for: .normal)
       }
    
    // MARK: - Configuration
       func configure(with item: BreakfastItem) {
           self.item = item
           
           lunchLabel.text = item.name
           
           lunchImgView.image = UIImage(named: item.imageURL)
           
           addBtn.isEnabled = item.isAvailable
           
           if !item.isAvailable {
               //addBtn.backgroundColor = .systemGray
               addBtn.isEnabled = false
           }
       }
    
}
