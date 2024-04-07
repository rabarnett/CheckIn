//
//  ListMessages.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct ListMessages: View {
    
    let messages: [Message]
    let title: String
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        VStack {
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
            
            ScrollView {
                ForEach(messages) { message in
                    MessageView(message: message)
                }
                .frame(maxWidth: .infinity)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ListMessages(messages: [], title: "Sent")
        .environmentObject(UserController())
}
