//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 12/06/2023.
//

import Foundation

struct Info: Codable {
    
    let version: Int
    
    let author: String
    
    static let `default`: Info = .init(version: 1, author: "xcode")
}
