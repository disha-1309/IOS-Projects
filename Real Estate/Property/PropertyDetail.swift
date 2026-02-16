//
//  PropertyDetail.swift
//  Real Estate
//
//  Created by Droisys on 21/09/25.
//

import Foundation

//struct PropertyDetail: Codable {
//    
//    let address: String
//    let image: String
//    let price:  String
//}

struct Product: Decodable {
    let title: String
    let price: Double
    let image: String
}
