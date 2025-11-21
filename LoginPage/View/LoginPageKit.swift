//
//  LoginPageKit.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 21/11/25.
//

import SwiftUI

struct LoginPageKit<Content:View>: View {
    
    init(_ appStorageId: String, @ViewBuilder content: @escaping() -> Content){
        self._isLoggedIn = .init(wrappedValue: false, appStorageId)
        self.content = content()
    }
    
    private var content: Content
    @AppStorage private var isLoggedIn: Bool
    
    var body: some View {
        ZStack{
            if isLoggedIn{
                content
            }else{
                LoginView()
            }
        }
    }
}

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPerforming: Bool = false
    
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
            IconTextField(placeholder: "Password", icon: "eye", isSecureTextEntry: true, value: $password)
            
            Button{
                
            }label: {
                Text("Forgot Password?")
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, 2)
            }
            
            TaskButton(title: "Sign In"){
                try? await Task.sleep(for: .seconds(5))
            }onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(!isSignInButtonEnabled)
            .padding(.top, 16)
            
            HStack{
                Text("Don't have an account?")
                Button{
                    
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
        .padding(.bottom, isIOS23 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.9 : 1)
    }
}


struct IconTextField: View {
    var placeholder: String
    var icon: String
    var isSecureTextEntry: Bool = false
    @Binding var value: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 30)
            Group{
                if isSecureTextEntry{
                    SecureField(placeholder, text: $value)
                }else{
                    TextField(placeholder, text: $value)
                }
            }
        }
        .font(.subheadline)
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(.ultraThinMaterial)
        .clipShape(.capsule)
    }
}

struct TaskButton: View {
    var title :String
    var task: () async -> ()
    var onStatusChange: (Bool) -> () = {_ in}
    @State private var isLoading: Bool = false
    
    var body: some View{
        Button{
            Task{
                isLoading = true
                await task()
                
                try? await Task.sleep(for: .seconds(0.1))
                isLoading = false
            }
        }label:{
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .opacity(isLoading ? 0 : 1)
                .overlay{
                    ProgressView()
                        .opacity(isLoading ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
        }
        .tint(.primary)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .animation(.easeInOut(duration: 0.25), value: isLoading)
        .disabled(isLoading)
        .onChange(of: isLoading){ oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.25)){
                onStatusChange(newValue)
            }
        }
    }
}

extension View {
    var isIOS23: Bool {
        if #available(iOS 26, *) {
            return true
        }else{
            return false
        }
    }
}

#Preview {
    ContentView()
}
