//
//  View+Extensions.swift
//  LoginPage
//
//  Created by Vaishnavi Deshmukh on 24/11/25.
//

import SwiftUI

extension View {
    var isIOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }else{
            return false
        }
    }
    
    @ViewBuilder
    func sheetAlert( isPresented: Binding<Bool>,
                     prominentSymbol: String,
                     title: String,
                     message: String,
                     buttonTittle: String,
                     buttonAction:@escaping () async -> ()) -> some View {
        self.sheet(isPresented: isPresented){
            VStack(spacing : 15){
                Image(systemName: prominentSymbol)
                    .font(.system(size: 100))
                
                VStack(alignment: .center, spacing: 6){
                    Text(title)
                        .lineLimit(1)
                    Text(message)
                        .lineLimit(2)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                TaskButton(title: buttonTittle){
                    await buttonAction()
                }
            }
            .padding([.horizontal, .top], 20)
            .padding(.bottom, isIOS26 ? 20 : 10)
            .presentationBackground(.background)
            .presentationDetents([.height(270)])
            .presentationCornerRadius(isIOS26 ? nil : 30)
            .ignoresSafeArea(isIOS26 ? .all : [])
            .interactiveDismissDisabled()
        }
        
    }
    
    @ViewBuilder
    func customAlert(_ modal: Binding<AlertModel>)-> some View{
        self
            .sheetAlert(isPresented: modal.show, prominentSymbol: modal.wrappedValue.icon, title: modal.wrappedValue.title, message: modal.wrappedValue.message, buttonTittle: "Done"){
                if let action = modal.wrappedValue.action{
                    action()
                }else{
                    modal.wrappedValue.show = false
                }
            }
    }
}

struct AlertModel{
    var icon: String = "exclamationmark.triangle.fill"
    var title: String = "Something Went Wrong!"
    var message: String
    var show: Bool = false
    var action : (() -> ())? = nil
}
