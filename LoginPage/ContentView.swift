//
//  ContentView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 21/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginPageKit("user_log_status"){
            NavigationStack{
                List{
                    
                }
                .navigationTitle("Welcome Back!")
            }
        }
    }
}

#Preview {
    ContentView()
}
