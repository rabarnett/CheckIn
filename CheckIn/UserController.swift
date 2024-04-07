//
//  UserController.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

final class UserController: DatabaseController {
    
    @Published private(set) var user: User?
    @Published private(set) var recievedMessages: [Message] = []
    @Published private(set) var sentMessages: [Message] = []
    
    override init() {
        super.init()
        do {
            try createStudentListener()
            try createRecievedMessageListener()
            try createSentMessageListener()
        } catch {
            print("ERROR IN UserController() - \(error)")
        }
    }
    
    /// Creates a listener that watches for changes to the student document in Firestore and updates the local representation of the student when necessary.
    @MainActor private func createStudentListener() throws {
        guard !path.invalidPaths else { throw AppError.invalidPath }
        print(#function)
        
        let studentDocument = database.document(path.to(.userDocument))
        
        studentDocument.addSnapshotListener {[weak self] docSnapshot, error in
            if let error {
                print("ERROR IN \(#function) - \(error)")
                return
            } else if let docSnapshot {
                self?.user = try? docSnapshot.data(as: User.self)
            }
        }
    }
    
    @MainActor private func createRecievedMessageListener() throws {
        guard !path.invalidPaths else { throw AppError.invalidPath }
        print(#function)
        
        let messagesCollection = database.collection(path.to(.userMessagesRecieved)).order(by: "timestamp")
        
        messagesCollection.addSnapshotListener {[weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("ERROR IN \(#function) - Failed to get documents")
                return
            }
            
            do {
                self?.recievedMessages = try documents.map {try $0.data(as: Message.self)}
            } catch {
                print("ERROR IN \(#function) - \(error)")
            }
        }
    }
    
    @MainActor private func createSentMessageListener() throws {
        guard !path.invalidPaths else { throw AppError.invalidPath }
        print(#function)
        
        let messagesCollection = database.collection(path.to(.userMessagesSent)).order(by: "timestamp")
        
        messagesCollection.addSnapshotListener {[weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("ERROR IN \(#function) - Failed to get documents")
                return
            }
            
            do {
                self?.sentMessages = try documents.map {try $0.data(as: Message.self)}
            } catch {
                print("ERROR IN \(#function) - \(error)")
            }
        }
    }
    
    func sendMessage(message: String) {
        print(#function)
        do {
            let time = Date.now
            let id = UUID()
            try setData(toDocument: path.to(.friendMessagesRecieved) + "/\(id.uuidString)", data: Message(message: message, timestamp: time, response: false), merge: false)
            try setData(toDocument: path.to(.userMessagesSent) + "/\(id.uuidString)", data: Message(message: message, timestamp: time, response: false), merge: false)
        } catch {
            print("Error IN \(#function) - \(error)")
        }
        
    }
    
    func confirmMessage(messageID: String?) {
        
        guard let messageID else {
            print("ERROR IN \(#function) - ID NIL")
            return
        }
        
        print(path.to(.friendMessagesRecieved) + "/\(messageID)")
        database.document(path.to(.friendMessagesSent) + "/\(messageID)").setData(["response": true], merge: true)
        database.document(path.to(.userMessagesRecieved) + "/\(messageID)").setData(["response": true], merge: true)
        
    }
    
    
}
