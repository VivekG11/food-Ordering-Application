//
//  MenuViewController.swift
//  Bing
//
//  Created by Vivek Guntuku on 27/04/25.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var fLabel: UILabel!
    
    @IBOutlet weak var circleCollectionView: UICollectionView!
    
    @IBOutlet weak var breakfastLabel: UILabel!
    
    @IBOutlet weak var breakFastCollectionView: UICollectionView!
    
    @IBOutlet weak var lunchCollectionView: UICollectionView!
    
    @IBOutlet weak var dinnerCollectionView: UICollectionView!
    
    private var breakfastItems: [BreakfastItem] = []
    
    private var lunchItems: [BreakfastItem] = []
    
    private var dinnerItems: [BreakfastItem] = []
    
    var result : [ResultItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flow = lunchCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = .zero
        }

        if let dinnerFlow = dinnerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            dinnerFlow.estimatedItemSize = .zero
        }

        loadbreakFastMenu()
        loadLunchMenu()
        loadDinnerMenu()
        
        guard let jPath = Bundle(for: type(of: self)).path(forResource: "data", ofType: "json") else {return
             }
             
             let url = URL(fileURLWithPath: jPath)
             
             do{
             let jsonData = try Data(contentsOf: url)
             let res = try JSONDecoder().decode(Result.self, from: jsonData)
                 result = res.data
                 print(res as Any)
                 DispatchQueue.main.async {
                     self.circleCollectionView.reloadData()
                 }

             }catch {
                 print("error")
             }
 
    }
    
    private func loadbreakFastMenu(){
        guard let jPath = Bundle(for: type(of: self)).path(forResource: "breakFast", ofType: "json") else {
            print("breakFast.json not found in the bundle")
            return
             }
        let url = URL(fileURLWithPath: jPath)
        
        do{
        let breakfastData = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([BreakfastItem].self, from: breakfastData)
            print("Decoded \(items.count) items")
            print(items)
            breakfastItems = items
            DispatchQueue.main.async {
                self.breakFastCollectionView.reloadData()
            }

        }catch {
            print("error")
        }
    }
    
    private func loadLunchMenu(){
        guard let jPath = Bundle(for: type(of: self)).path(forResource: "lunch", ofType: "json") else {
            print("lunch.json not found in the bundle")
            return
             }
        let url = URL(fileURLWithPath: jPath)
        
        do{
        let lunchData = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([BreakfastItem].self, from: lunchData)
            print("Decoded \(items.count) items")
            print(items)
            lunchItems = items
            DispatchQueue.main.async {
                self.lunchCollectionView.reloadData()
            }

        }catch {
            print("error")
        }
    }
    
    private func loadDinnerMenu(){
        guard let jPath = Bundle(for: type(of: self)).path(forResource: "dinner", ofType: "json") else {
            print("dinner.json not found in the bundle")
            return
             }
        let url = URL(fileURLWithPath: jPath)
        
        do{
        let dinnerData = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([BreakfastItem].self, from: dinnerData)
            print("Decoded \(items.count) items")
            print(items)
            dinnerItems = items
            DispatchQueue.main.async {
                self.dinnerCollectionView.reloadData()
            }

        }catch {
            print("error")
        }
        
    }
    
    @objc func addToCartButtonTapped(_ sender: UIButton) {
            // Get the index of the tapped item
        let point = sender.convert(CGPoint.zero, to: breakFastCollectionView)
        if let indexPath = breakFastCollectionView.indexPathForItem(at: point) {
                let item = breakfastItems[indexPath.item]
            
                print("Added to cart: \(item.name)")
            sender.setTitle("Added to cart", for: .normal)
            sender.backgroundColor = .systemGreen
            }
        let lPoint = sender.convert(CGPoint.zero, to: lunchCollectionView)
        if let indexPath = lunchCollectionView.indexPathForItem(at: lPoint) {
                let item = breakfastItems[indexPath.item]
            
                print("Added to cart: \(item.name)")
            sender.setTitle("Added to cart", for: .normal)
            sender.backgroundColor = .systemGreen
            }
        let dPoint = sender.convert(CGPoint.zero, to: dinnerCollectionView)
        if let indexPath = dinnerCollectionView.indexPathForItem(at: dPoint) {
                let item = breakfastItems[indexPath.item]
            
                print("Added to cart: \(item.name)")
            sender.setTitle("Added to cart", for: .normal)
            sender.backgroundColor = .systemGreen
            }
        }
    
}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == circleCollectionView{
            return result.count
        }else if collectionView == breakFastCollectionView {
            return breakfastItems.count
        }else if collectionView == lunchCollectionView {
            return lunchItems.count
        }else if collectionView == dinnerCollectionView {
            return dinnerItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == circleCollectionView{
            let cell = circleCollectionView.dequeueReusableCell(withReuseIdentifier: "circleCollectionViewCell", for: indexPath) as! circleCollectionViewCell
            cell.contentView.layer.cornerRadius = cell.contentView.frame.width/2
            cell.contentView.layer.masksToBounds = true
            let parsedData = result[indexPath.row]
            print(parsedData as Any)
            cell.roundImgView.image = UIImage(named: parsedData.img) ?? UIImage(named: "slideImg1")
 
            return cell
            
        }else if collectionView == breakFastCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "breakFastCollectionViewCell", for: indexPath) as! breakFastCollectionViewCell
        
            let item = breakfastItems[indexPath.row]
            cell.configure(with: item)
            cell.addBtn.tag = indexPath.item
            cell.addBtn.addTarget(self, action: #selector(addToCartButtonTapped(_:)), for: .touchUpInside)
            return cell
        }else if collectionView == lunchCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lunchCollectionViewCell", for: indexPath) as! lunchCollectionViewCell
        
            let item = lunchItems[indexPath.row]
            cell.configure(with: item)
            cell.addBtn.tag = indexPath.item
            cell.addBtn.addTarget(self, action: #selector(addToCartButtonTapped(_:)), for: .touchUpInside)
            return cell
        }else if collectionView == dinnerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dinnnerCollectionViewCell", for: indexPath) as! dinnnerCollectionViewCell
        
            let item = dinnerItems[indexPath.row]
            cell.configure(with: item)
            cell.addBtn.tag = indexPath.item
            cell.addBtn.addTarget(self, action: #selector(addToCartButtonTapped(_:)), for: .touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == circleCollectionView{
            cell.layer.cornerRadius = cell.bounds.width/2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == circleCollectionView{
            
            let halfWidth = (collectionView.bounds.width)/2.5533
            
            return CGSize(width: halfWidth, height: halfWidth)
        }else if collectionView == breakFastCollectionView{
            let width = (collectionView.bounds.width)/1.915
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        } else if collectionView == lunchCollectionView{
                let width = (collectionView.bounds.width)/1.915
                let height = collectionView.bounds.height
                return CGSize(width: width, height: height)
        }else if collectionView == dinnerCollectionView{
            let width = (collectionView.bounds.width)/1.915
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
    }
        return .zero
    }
}
