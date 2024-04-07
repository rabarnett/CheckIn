//
//  ListMessages.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct ListMessages: View {
    
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        VStack {
            Text(userController.user?.username ?? "ERROR")
            
            ForEach(userController.messages, id: \.self) { message in
                VStack {
                    Text(message.message)
                    Text(message.timestamp.description)
                }
            }
        }
    }
}

#Preview {
    ListMessages()
        .environmentObject(UserController())
}
