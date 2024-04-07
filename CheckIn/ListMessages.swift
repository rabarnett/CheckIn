//
//  ListMessages.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct ListMessages: View {
    
    let messages: [Message]
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        ScrollView {
            ForEach(messages) { message in
                MessageView(message: message)
            }
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ListMessages(messages: [])
        .environmentObject(UserController())
}
