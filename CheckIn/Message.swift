//
//  Message.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

struct Message: Codable, Hashable {
    
    var message: String
    var timestamp: Date
    var response: Bool
    
}
