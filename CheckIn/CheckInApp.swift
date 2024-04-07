//
//  CheckInApp.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct CheckInApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userController = UserController()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(userController)
        }
    }
}
