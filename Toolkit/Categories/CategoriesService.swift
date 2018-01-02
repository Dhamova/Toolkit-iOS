//
//  File.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import Foundation
import Firebase


extension UIViewController {
    func getAllCategories(completion: @escaping (_ result: [Category]?, _ error: Error?) -> Void) {
        Firestore.firestore().collection("categories").getDocuments { (snapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
                completion(nil, error)
            } else {
                do  {
                    var results = [Category]()
                    for document in snapshot!.documents {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        results.append(try JSONDecoder().decode(Category.self, from: jsonData!))
                    }
                    completion(results, nil)
                } catch {
                    completion(nil, error)
                }
                
            }
            
        }
    }
}


