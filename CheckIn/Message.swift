//
//  Message.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Hashable, Identifiable {
    
    @DocumentID var id: String?
    var message: String
    var timestamp: Date
    var response: Bool
    
}
