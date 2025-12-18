//
//  RegisterAccountView.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI
import FirebaseAuth

struct RegisterAccountView: View {
    var onSuccessLogin: () -> () = { }
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPerforming: Bool = false
    @State private var alert: AlertModel = .init(message: "")
    @State private var userVerificationModal : Bool = false
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    private func createNewAccount() async {
        do{
            let auth = Auth.auth()
            let result = try await auth.createUser(withEmail: email, password: password)
            try await result.user.sendEmailVerification()
            userVerificationModal = true
        }catch{
            alert.message = error.localizedDescription
            alert.show = true
        }
    }
    
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
                isFocused = false
                await createNewAccount()
                //                try? await Task.sleep(for: .seconds(5))
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
        .focused($isFocused)
        .customAlert($alert)
        .interactiveDismissDisabled(isFocused || isPerforming)
        .sheetAlert(isPresented: $userVerificationModal,
                    prominentSymbol: "envelope.badge",
                    title: "Email Verification",
                    message: "We have sent a verification email to\nyour address. Please check your inbox.",
                    buttonTittle: "Verified?",
                    buttonAction: {
            if let user = Auth.auth().currentUser {
                try? await user.reload()
                if user.isEmailVerified{
                    print("Success!")
                    dismiss()
                    try? await Task.sleep(for: .seconds(0.25))
                    onSuccessLogin()
                    
                }
            }
            
        }
        )
    }
}

#Preview {
    RegisterAccountView()
}
