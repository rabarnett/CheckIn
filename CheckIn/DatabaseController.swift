//
//  DatabaseController.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation
import FirebaseFirestore

/// Manages reading and writing to Firestore and Storage.
class DatabaseController: ObservableObject {
    // TODO: Make static properties
    
    /// The Firestore database.
    let database = Firestore.firestore()
    
    /// Paths to specific collections/documents in the Firestore database.
    var path = DatabasePath()
    
    @MainActor init() {}
    
    /**
     Fetches data from a document in Firestore.
     - Parameter fromDocument: The document to fetch the data from.
     - Returns: The document decoded into the specified type.
     - Throws: An error if the user is offline, the server cannot be reached, or the data cannot be decoded.
     - Authors: Reese Barnett
    */
    func fetch<T: Decodable>(fromDocument document: DatabasePath.PathType) async throws -> T {
        print("\(#function) \(T.self)")
        let document = try await database.document(path.to(document)).getDocument()
        return try document.data(as: T.self)
    }
    
    func fetch<T: Decodable>(fromCollection pathType: DatabasePath.PathType) async throws -> [T] {
            print("\(#function) [\(T.self)]")
            let documents = try await database.collection(path.to(pathType)).getDocuments().documents
            return try documents.map {try $0.data(as: T.self)}
        }
    
    // TODO: Is there an async method for setting data
    func setData<T: Encodable>(toDocument document: DatabasePath.PathType, data: T, merge: Bool) throws {
        try database.document(path.to(document)).setData(from: data, merge: merge)
    }
    
    func setData<T: Encodable>(toDocument document: String, data: T, merge: Bool) throws {
        try database.document(document).setData(from: data, merge: merge)
    }
    
    func pushData<T: Encodable>(toCollection collection: DatabasePath.PathType, data: T) throws {
        try database.collection(path.to(collection)).addDocument(from: data)
    }
    
    
    
}
