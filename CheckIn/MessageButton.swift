//
//  MessageButton.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct MessageButton: View {
    
    let message: String
    
    @EnvironmentObject private var userController: UserController
    var body: some View {
        Button {
            userController.sendMessage(message: message)
        } label: {
            Text(message)
                .foregroundStyle(.black)
                .frame(width: 150, height: 150)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.yellow)
                }
        }
    }
}

#Preview {
    MessageButton(message: "On my way!")
}
