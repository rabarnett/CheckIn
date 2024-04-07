//
//  ContentView.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        TabView {
            MessageSelect()
                .tabItem {
                    Label("Message Select", systemImage: "app.connected.to.app.below.fill")
                }
            
            ListMessages(messages: userController.recievedMessages, title: "Recieved")
                .tabItem {
                    Label("Recieved", systemImage: "clock.fill")
                }
            
            ListMessages(messages: userController.sentMessages, title: "Sent")
                .tabItem {
                    Label("Sent", systemImage: "paperplane.fill")
                }
            
            RouteView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserController())
}
