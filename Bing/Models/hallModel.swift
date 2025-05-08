//
//  hallModel.swift
//  Bing
//
//  Created by Vivek Guntuku on 14/04/25.
//

import UIKit

struct Result : Codable {
    let data : [ResultItem]
}

struct ResultItem : Codable {
    let img : String
    let description : String
    
    enum CodingKeys: String, CodingKey {
            case img
            case description
            
        }

}

