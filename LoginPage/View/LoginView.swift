//
//  LoginView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPerforming: Bool = false
    @State private var createAccount: Bool = false
    @State private var forgotPassword: Bool = false
    @State private var userNotVerified: Bool = false
    @State private var alert: AlertModel = .init(message: "")
    
    @FocusState private var isFocused: Bool
    
    var isSignInButtonEnabled : Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            VStack(alignment: .leading,spacing: 8){
                Text("Welcom Back")
                    .font(.largeTitle)
                Text("Please sign in to continue")
                    .font(.subheadline)
            }
            .fontWeight(.medium)
            .padding(.top, 5)
            
            IconTextField(placeholder: "Email Address", icon: "envelope", value: $email)
            IconTextField(placeholder: "Password", icon: "lock", isSecureTextEntry: true, value: $password)
            
            Button{
                forgotPassword.toggle()
            }label: {
                Text("Forgot Password?")
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, 2)
            }
            
            TaskButton(title: "Sign In"){
                isFocused = false
                try? await Task.sleep(for: .seconds(1))
                alert.message = "There is no user with this email"
                alert.show.toggle()
            }onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(!isSignInButtonEnabled)
            .padding(.top, 16)
            
            HStack{
                Text("Don't have an account?")
                Button{
                    createAccount.toggle()
                }label: {
                    Text("Sign Up Here")
                        .underline()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            HStack{
                Link("Terms of Services", destination: URL(string: "https://apple.com")!)
                    .underline()
                Text("&")
                Link("Privacy Policy", destination: URL(string: "https://youtube.com")!)
                    .underline()
            }
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.horizontal, .top], 20)
        .padding(.bottom, isIOS26 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.9 : 1)
        .sheet(isPresented: $createAccount){
            RegisterAccountView()
                .presentationDetents([.height(400)])
                .presentationBackground(.background)
                .presentationCornerRadius(isIOS26 ? nil : 30)
        }
        .sheet(isPresented: $forgotPassword){
            ForgotPasswordView()
                .presentationDetents([.height(250)])
                .presentationBackground(.background)
                .presentationCornerRadius(isIOS26 ? nil : 30)
        }
        .sheetAlert(isPresented: $userNotVerified, prominentSymbol: "envelope.badge", title: "Email Verification", message: "We have sent a verification email to\nyour address. Please check your inbox.", buttonTittle: "Verified?", buttonAction: {
            
        })
        .customAlert($alert)
        .focused($isFocused)
    }
}

#Preview {
    LoginView()
}
