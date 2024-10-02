//
//  BackgroundImageView.swift
//  Devote
//
//  Created by gizem demirtas on 1.10.2024.
//

import SwiftUI

struct BackgroundImageView: View {
    // MARK: - PROPERTIES
    
    
    
    // MARK: - BODY
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 800, minHeight: 840)
            .ignoresSafeArea(.all)
    }
}

    // MARK: - PREVIEW
#Preview {
    BackgroundImageView()
}
