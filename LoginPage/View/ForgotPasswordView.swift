//
//  ForgotPasswordView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var emailAddress: String = ""
    @State private var isPerforming: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            VStack(alignment: .leading, spacing: 8){
                Text("Forgot Password")
                    .font(.title)
                
                Text("Don't worry we will send you a link to reset it.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .fontWeight(.medium)
            
            IconTextField(placeholder: "Email Address", icon: "envelope", value: $emailAddress)
                .padding(.top, 10)
            
            TaskButton(title: "Send reset link"){
                //            try? await Task.sleep(for: .seconds(5))
            }onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(emailAddress.isEmpty)
            .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.top, 25)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.7 : 1)
    }
    
    
}

#Preview {
    ForgotPasswordView()
}
