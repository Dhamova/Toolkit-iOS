//
//  ProviderViewController.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {

    var currentProvider: Provider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentProvider.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
