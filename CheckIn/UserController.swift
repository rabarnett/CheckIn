//
//  UserController.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

final class UserController: DatabaseController {
    
    @Published private(set) var user: User?
    @Published private(set) var messages: [Message] = []
    
    override init() {
        super.init()
        do {
            try createStudentListener()
            try createMessageListener()
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
    
    @MainActor private func createMessageListener() throws {
        guard !path.invalidPaths else { throw AppError.invalidPath }
        print(#function)
        
        let messagesCollection = database.collection(path.to(.userMessages)).order(by: "timestamp")
        
        messagesCollection.addSnapshotListener {[weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("ERROR IN \(#function) - Failed to get documents")
                return
            }
            
            do {
                self?.messages = try documents.map {try $0.data(as: Message.self)}
            } catch {
                print("ERROR IN \(#function) - \(error)")
            }
        }
    }
    
    func sendMessage(message: String) {
        print(#function)
        do {
            try pushData(toCollection: .friendMessages, data: Message(message: message, timestamp: .now, response: false))
        } catch {
            print("Error IN \(#function) - \(error)")
        }
        
    }
    
    
}
