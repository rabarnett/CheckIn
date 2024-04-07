//
//  MessageView.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/7/24.
//

import SwiftUI

struct MessageView: View {
    
    let message: Message
    
    @EnvironmentObject private var userController: UserController
    var body: some View {
        VStack {
            
            Text(message.message)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            if(message.response) {
                Text("Seen")
                    .foregroundStyle(.green)
            } else {
                Button("OK") {
                    userController.confirmMessage(messageID: message.id)
                }
                
            }
            
            Text(message.timestamp.formatted(.dateTime.month().day().hour().minute()))
                .font(.system(size: 14, weight: .regular, design: .rounded))
        }
        .frame(width: 300, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.purple)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 3)
                }
        }
    }
}

#Preview {
    MessageView(message: Message(id: nil, message: "SOS", timestamp: .now, response: false))
        .environmentObject(UserController())
}
