//
//  DatabasePath.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

/// Contains the paths to collections/documents in the Firestore database.
struct DatabasePath {
    
    private let friendID = "Ya8UEN1DuTsKFZLUXeVa"
    
    private let userID = "OvsuB2c2ZHCLsEWx9T0V"
    
    /// The name of the collection that contains the users.
    private let usersCollection = "users"
    
    private let messagesReceivedCollection = "messagesReceived"
    
    private let messagesSentCollection = "messagesSent"
    
    private let userDocument: String
    
    private let friendDocument: String
    
    private let friendMessagesRecieved: String
    
    private let userMessagesRecieved: String
    
    private let friendMessagesSent: String
    
    private let userMessagesSent: String
    
    let invalidPaths: Bool
    
    
    init() {
        invalidPaths = friendID.isEmpty
        friendDocument = "\(usersCollection)/\(friendID)"
        userDocument = "\(usersCollection)/\(userID)"
        friendMessagesRecieved = "\(friendDocument)/\(messagesReceivedCollection)"
        userMessagesRecieved = "\(userDocument)/\(messagesReceivedCollection)"
        friendMessagesSent = "\(friendDocument)/\(messagesSentCollection)"
        userMessagesSent = "\(userDocument)/\(messagesSentCollection)"
    }
    
    /**
     Gets the path to a specific collection or document in Firestore.
     - Parameter pathType: The collection or document the path leads to.
     - Returns: The path to the specified collection/document.
    */
    func to(_ pathType: PathType) -> String {
        
        switch pathType {
        case .userDocument:
            userDocument
        case .friendDocument:
            friendDocument
        case .userMessagesRecieved:
            userMessagesRecieved
        case .friendMessagesRecieved:
            friendMessagesRecieved
        case .userMessagesSent:
            userMessagesSent
        case .friendMessagesSent:
            friendMessagesSent
        }
        
    }
    
    
    /// Collections/documents in Firestore.
    enum PathType {
        case userDocument
        case friendDocument
        case userMessagesRecieved
        case friendMessagesRecieved
        case userMessagesSent
        case friendMessagesSent
    }
    
}
