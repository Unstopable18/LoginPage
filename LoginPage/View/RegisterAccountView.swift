//
//  RegisterAccountView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI

struct RegisterAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPerforming: Bool = false
    
    var isSignInButtonEnabled : Bool {
        !email.isEmpty && !password.isEmpty && password == confirmPassword
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            VStack(alignment: .leading,spacing: 8){
                Text("Let's get you started")
                    .font(.title)
                Text("It's quick and easy.")
                    .textScale(.secondary)
            }
            .fontWeight(.medium)
            .padding(.top, 5)
            
            IconTextField(placeholder: "Email Address", icon: "envelope", value: $email)
            IconTextField(placeholder: "Password", icon: "lock", isSecureTextEntry: true, value: $password)
            IconTextField(placeholder: "Confirm Password", icon: "eye", value: $confirmPassword)
            
            TaskButton(title: "Create Account"){
                try? await Task.sleep(for: .seconds(5))
            }onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(!isSignInButtonEnabled)
            .padding(.top, 16)
            
            Spacer()
            
            HStack{
                Link("By creating an account, you agree to out Terms and privacy policy", destination: URL(string: "https://apple.com")!)
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .underline()
            }
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.horizontal, .top], 20)
        .padding(.bottom, isIOS26 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.9 : 1)
    }
}

#Preview {
    RegisterAccountView()
}
