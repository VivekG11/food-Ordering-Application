//
//  diningHallViewController.swift
//  Bing
//
//  Created by Vivek Guntuku on 26/04/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class diningHallViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var dineCollectionView: UICollectionView!
    
    @IBOutlet weak var firstHallLabel: UILabel!
    
    @IBOutlet weak var c4CollectionView: UICollectionView!
    
    var result : Result?
    
    let diningHallNames = ["C4", "Hinman", "Marketplace", "Appalachian"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"

        if let flow = dineCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = .zero
        }

        if let hallFlow = c4CollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            hallFlow.estimatedItemSize = .zero
        }
        // Do any additional setup after loading the view.
        //view.backgroundColor = .lightGray
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        let user = db.collection("users").document(userID)
        
        //fetch user data
        user.getDocument{ [weak self] (document,error) in
            if let error = error {
                print("Error getting user data\(error)")
                return
            }
            
            if let document = document, document.exists{
                if let data = document.data(),
                   let name = data["name"] as? String {
                    self?.titlelabel.text = "Welcome \(name)"
                }
            }
            
        }
        firstHallLabel.text = "Dining Halls"
        
        let items = [
                   ResultItem(img: "BCrew", description: "Chenango Champlain Collegiate Center"),
                   ResultItem(img: "Hinman", description: "Hinman Dining Hall"),
                   ResultItem(img: "ciw", description: "Market Place"),
                   ResultItem(img: "c4", description: "Applachian Dining Hall")
               ]
               
               self.result = Result(data: items)
               print("Hardcoded Data loaded: \(result?.data ?? [])")
        
    }
        
    }
    

extension diningHallViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dineCollectionView{
            return result?.data.count ?? 0
        }else if collectionView == c4CollectionView{
            return result?.data.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dineCollectionView{
            let cell = dineCollectionView.dequeueReusableCell(withReuseIdentifier: "dineCollectionViewCell", for: indexPath) as! dineCollectionViewCell
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 3
            cell.layer.shadowOpacity = 0.2
            
            if let item = result?.data[indexPath.row] {
                if let image = cell.slideImg{
                    image.image = UIImage(named: item.img)
                }
               // cell.slideLbl.text = item.description
            }
            return cell
        }else if collectionView == c4CollectionView{
            let cell = c4CollectionView.dequeueReusableCell(withReuseIdentifier: "c4CollectionViewCell", for: indexPath) as! c4CollectionViewCell
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
           // cell.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 3
            cell.layer.shadowOpacity = 0.2
            if let item = result?.data[indexPath.row] {
                if let image = cell.cImgView{
                    image.image = UIImage(named: item.img)
                }
                cell.cLabel.text = item.description
            }
            return cell
        }
        return UICollectionViewCell()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == c4CollectionView{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(identifier: "MenuViewController") as? MenuViewController {
                vc.title = diningHallNames[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == dineCollectionView{
            
           let safeFrame = view.safeAreaLayoutGuide.layoutFrame
            
            let width  = safeFrame.width
            let height = safeFrame.height * 0.2700

            return CGSize(width: width, height: height)
        }
        
        if collectionView == c4CollectionView{
            let width = collectionView.bounds.width
            let height = (collectionView.bounds.height)/2
            
            return CGSize(width: width, height: height)
            
        }
        
        return .zero
        
    }
    
    
}



