//
//  c4CollectionViewCell.swift
//  Bing
//
//  Created by Vivek Guntuku on 27/04/25.
//

import UIKit

class c4CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var c4StackView: UIStackView!
    
    @IBOutlet weak var cImgView: UIImageView!
    
    
    @IBOutlet weak var cLabel: UILabel!
    
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
        cImgView.contentMode = .scaleAspectFill
        cImgView.clipsToBounds = true
        cImgView.layer.cornerRadius = 6
           
           // Name label setup
        cLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cLabel.adjustsFontForContentSizeCategory = true
        cLabel.textColor = .label
        cLabel.numberOfLines = 2
           
       }
    
    
}
