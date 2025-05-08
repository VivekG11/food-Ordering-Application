//
//  Untitled.swift
//  Bing
//
//  Created by Vivek Guntuku on 29/04/25.
//

import UIKit

struct BreakfastItem: Codable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageURL = "image_url"
        case isAvailable = "is_available"
    }
}

// MARK: - Data Manager
class BreakfastDataManager {
    
    static let shared = BreakfastDataManager()
    
    private init() {}
    
    func loadBreakfastItems(completion: @escaping ([BreakfastItem]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "breakFast", ofType: "json") else {
            print("Error: Couldn't find breakfast_items.json in the bundle")
            completion(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let breakfastItems = try JSONDecoder().decode([BreakfastItem].self, from: data)
            completion(breakfastItems)
            print("BreakfastItems \(breakfastItems)")
        } catch {
            print("Error loading breakfast items: \(error)")
            completion(nil)
        }
    }
}
