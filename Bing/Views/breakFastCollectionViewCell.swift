//
//  breakFastCollectionViewCell.swift
//  Bing
//
//  Created by Vivek Guntuku on 29/04/25.
//

import UIKit

class breakFastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bfStackView: UIStackView!
    
    @IBOutlet weak var bfImageView: UIImageView!
    
    @IBOutlet weak var bfLabel: UILabel!
    
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
           bfImageView.contentMode = .scaleAspectFill
           bfImageView.clipsToBounds = true
           bfImageView.layer.cornerRadius = 6
           
           // Name label setup
        bfLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bfLabel.adjustsFontForContentSizeCategory = true
        bfLabel.textColor = .label
        bfLabel.numberOfLines = 2
           
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
           
           bfLabel.text = item.name
           
           bfImageView.image = UIImage(named: item.imageURL)
           
           addBtn.isEnabled = item.isAvailable
          if !item.isAvailable {
              addBtn.isEnabled = false
              // addBtn.backgroundColor = .systemGray
           }
       }
    
}


