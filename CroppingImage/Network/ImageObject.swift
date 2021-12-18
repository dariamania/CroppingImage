//
//  ImageObject.swift
//  CroppingImage
//
//  Created by Dariia Pavlovskaya on 17.12.2021.
//

import UIKit

struct Images: Codable {
    
    let items: [ImageObject]
    
}

struct ImageObject: Codable {
    
    let title: String
    let date: String
    let teaser: String
    let image: String
    let text: String
    
}
