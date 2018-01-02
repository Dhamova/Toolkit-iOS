//
//  ViewController.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import UIKit
import AlamofireImage
import SafariServices

class MainViewController: UIViewController {

    var categories = [Category]()
    var promos = [Promo]()
    
    var promoImageView = UIImageView(frame: CGRect.zero)
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCategoriesTable()
        setUpPromoView()
        loadCategories()
        loadPromoHeader()
    }
    
    
    @IBAction func goToContact(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: "https://www.dhamova.com/contact/")!)
        svc.preferredControlTintColor = UIColor.black
        self.present(svc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCategory" {
            let vc = segue.destination as! CategoryViewController
            vc.currentCategory = sender as! Category
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpCategoriesTable() {
        categoriesTableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    func loadCategories() {
        getAllCategories { (categories, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.categories = categories!
                self.categories.sort(by: { (c1, c2) -> Bool in
                    return c1.name <= c2.name
                })
                self.categoriesTableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Categories"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath)
            
            let currentCategory = categories[indexPath.row]
            
            let colorStripe = cell.viewWithTag(1)!
            if let color = currentCategory.color {
                colorStripe.backgroundColor = UIColor(hex: color)
            }
            
            let labelName = cell.viewWithTag(2) as! UILabel
            labelName.text = currentCategory.name
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCTA", for: indexPath)
            
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "")
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "ShowCategory", sender: categories[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "ShowCategory", sender: categories[indexPath.row])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y + 200)
        let height = min(max(y, 0), 400)
        promoImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
}

extension MainViewController {
    
    func setUpPromoView() {
        promoImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        promoImageView.contentMode = .scaleAspectFill
        promoImageView.clipsToBounds = true
        view.addSubview(promoImageView)
    }
    
    func loadPromoHeader() {
        getPromosHeader { (promos, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.promos = promos!
                let randomIndex = Int(arc4random_uniform(UInt32(self.promos.count)))
                if let urlImage = URL(string: self.promos[randomIndex].imageURL) {
                    self.promoImageView.af_setImage(withURL: urlImage)
                }
            }
        }
    }
    
}

