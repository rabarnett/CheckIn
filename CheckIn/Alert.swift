//
//  Alert.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct Alert: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundStyle(.black)
                .frame(width: 200, height: 100)
            
            Button {
                
            } label: {
                Text("Ok")
                    .foregroundStyle(.red)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 50, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 7)
            }
            .padding(.bottom)

        }
        .background {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.blue)
        }
            
    }
}

#Preview {
    Alert(message: "Hari is on his way")
}
