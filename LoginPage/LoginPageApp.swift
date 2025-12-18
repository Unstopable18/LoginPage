//
//  LoginPageApp.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 21/11/25.
//

import SwiftUI
import Firebase
@main
struct LoginPageApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
