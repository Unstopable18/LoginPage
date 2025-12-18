//
//  ForgotPasswordView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var emailAddress: String = ""
    @State private var isPerforming: Bool = false
    @State private var alert: AlertModel = .init(message: "")
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    private func sendPasswordResetLink() async {
        do{
            let auht = Auth.auth()
            try await auht.sendPasswordReset(withEmail: emailAddress)
            alert = .init(icon: "checkmark.circle.fill", title: "Email Sent!", message: "Check email with a link to rest your password", show: true, action: {
                dismiss()
            })
        } catch{
            alert.message = error.localizedDescription
            alert.show = true
        }
    }
    
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
                isFocused = false
                await sendPasswordResetLink()
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
        .focused($isFocused)
        .customAlert($alert)
        .interactiveDismissDisabled(isFocused || isPerforming)
    }
    
    
}

#Preview {
    ForgotPasswordView()
}
