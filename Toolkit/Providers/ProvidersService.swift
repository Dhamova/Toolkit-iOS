//
//  ProvidersServices.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIViewController {
    func getProvidersForCategory(categoryId: String, completion: @escaping (_ result: [Provider]?, _ error: Error?) -> Void) {
        Firestore.firestore().collection("providers").whereField("categoryId", isEqualTo: categoryId).getDocuments { (snapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
                completion(nil, error)
            } else {
                do  {
                    var results = [Provider]()
                    for document in snapshot!.documents {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        results.append(try JSONDecoder().decode(Provider.self, from: jsonData!))
                    }
                    completion(results, nil)
                } catch {
                    completion(nil, error)
                }
                
            }
        }
    }
}
