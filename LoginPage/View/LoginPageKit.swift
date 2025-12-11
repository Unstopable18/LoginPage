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

#Preview {
    ContentView()
}
