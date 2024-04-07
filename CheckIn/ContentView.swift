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
        VStack {
            MessageSelect()
            
            ScrollView {
                ListMessages()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserController())
}
