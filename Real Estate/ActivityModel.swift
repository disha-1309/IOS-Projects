//
//  ActivityModel.swift
//  Real Estate
//
//  Created by Droisys on 03/10/25.
//

import Foundation
struct Account: Decodable {
    let accountName: String
    let clientName: String
    
    enum CodingKeys: String, CodingKey {
        case accountName = "AccountName"
        case clientName = "ClientName"
    }
}

struct APIResponse: Decodable {
    let status: Int?
    let message: String?
    let result: [Account]?
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message = "Message"
        case result = "Result"
    }
}
