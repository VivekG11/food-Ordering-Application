//
//  circleCollectionViewCell.swift
//  Bing
//
//  Created by Vivek Guntuku on 28/04/25.
//

import UIKit

class circleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var roundImgView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundImgView.layer.cornerRadius = self.frame.width/2.0
    }
    
}
