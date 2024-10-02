//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by gizem demirtas on 29.09.2024.
//

import SwiftUI

#if canImport(UIKit)  //Klavyeyi kapatma kodu(Swift UI doğrudan klavye kapatma kodu olmadığı için UI Kit ile yazdık)
extension View {
    func hideKeyboard (){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

