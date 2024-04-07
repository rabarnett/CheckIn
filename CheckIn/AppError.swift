//
//  AppError.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import Foundation

/// A profile for errors that occur during the authentication process.
enum AppError: Error, LocalizedError {
    
    /// The function call has invalid arguments.
    case invalidArgument
    
    /// The result of the fetch is empty.
    case fetchDataEmpty
    
    /// The Firestore read/write cannot be executed because the path is invalid.
    case invalidPath
    
    /// The fetch failed. No data to return.
    case failedFetch
    
    /// Descriptions used to print the errors in a readable format.
    public var errorDescription: String? {
        switch self {
        case .invalidArgument:
            return "The function call has invalid arguments."
        case .fetchDataEmpty:
            return "The result of the fetch is empty."
        case .invalidPath:
            return "The Firestore read/write cannot be executed because the path is invalid."
        case .failedFetch:
            return "The fetch failed. No data to return."
        }
    }
}
