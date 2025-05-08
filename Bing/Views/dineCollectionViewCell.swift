//
//  dineCollectionViewCell.swift
//  Bing
//
//  Created by Vivek Guntuku on 27/04/25.
//

import UIKit

class dineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stView: UIStackView!
    
    @IBOutlet weak var slideImg: UIImageView!
    
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
        slideImg.contentMode = .scaleAspectFill
        slideImg.clipsToBounds = true
        slideImg.layer.cornerRadius = 6
                      
       }
    
    
}
