//
//  CategoryViewController.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryViewController: UIViewController {
    
    var currentCategory: Category!

    var providers = [Provider]()
    @IBOutlet weak var providersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentCategory.name
        setUpProvidersTable()
        loadProviders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProvider" {
            let vc = segue.destination as! ProviderViewController
            vc.currentProvider = sender as! Provider
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpProvidersTable() {
        providersTableView.delegate = self
        providersTableView.dataSource = self
    }
    
    func loadProviders() {
        getProvidersForCategory(categoryId: currentCategory.id) { (providers, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.providers = providers!
                self.providersTableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellProvider", for: indexPath)
        
        let currentProvider = providers[indexPath.row]
        
        let logoImageView = cell.viewWithTag(1) as! UIImageView
        if let logoURL = URL(string: currentProvider.logoURL) {
            logoImageView.af_setImage(withURL: logoURL)
        }
        
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = currentProvider.name
        
        let shortDescriptionLabel = cell.viewWithTag(3) as! UILabel
        shortDescriptionLabel.text = currentProvider.shortDescription
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowProvider", sender: providers[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowProvider", sender: providers[indexPath.row])
    }
    
}
