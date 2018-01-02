//
//  Provider.swift
//  Toolkit
//
//  Created by David Cruz on 1/2/18.
//  Copyright © 2018 Dhamova. All rights reserved.
//

import Foundation

struct Provider: Codable {
    let id: String!
    let categoryId: String!
    let name: String!
    let logoURL: String!
    let longDescription: String?
    let shortDescription: String?
    let websiteURL: String?
    let videoURLs: [String]?
}
