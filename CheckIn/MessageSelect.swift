//
//  MessageSelect.swift
//  CheckIn
//
//  Created by Reese Barnett on 4/6/24.
//

import SwiftUI

struct MessageSelect: View {
    
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        Grid {
            GridRow {
                MessageButton(message: "On my way")
                MessageButton(message: "Arrived")
            }
            
            GridRow {
                MessageButton(message: "Leaving")
                MessageButton(message: "SOS")
            }
        }
    }
}

#Preview {
    MessageSelect()
        .environmentObject(UserController())
}
