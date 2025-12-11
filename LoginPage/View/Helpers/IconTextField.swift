//
//  IconTextField.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI

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
