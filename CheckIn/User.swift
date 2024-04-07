//
//  User.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

struct User: Codable {
    
    var username: String
    var password: String
    var friendID: String
    
    /// Specifies the name of the attributes in the Firestore document.
   enum CodingKeys: String, CodingKey {
       case username
       case password
       case friendID
   }
    
}
