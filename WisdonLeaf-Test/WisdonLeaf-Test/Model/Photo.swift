//
//  Photo.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 11/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
