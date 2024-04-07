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
                VStack {
                    Text(message.message)
                    Text(message.timestamp.description)
                    if(message.response) {
                        Text("Seen")
                            .foregroundStyle(.green)
                    } else {
                        Button("OK") {
                            userController.confirmMessage(messageID: message.id)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ListMessages(messages: [])
        .environmentObject(UserController())
}
