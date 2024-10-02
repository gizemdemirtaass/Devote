//
//  BlankView.swift
//  Devote
//
//  Created by gizem demirtas on 1.10.2024.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTIES
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
        /*
         blendMode(.overlay), iki katman arasındaki renklerin nasıl karışacağını belirler.
         Koyu bölgeleri daha koyu, açık bölgeleri daha açık yapar.
         İki katman arasındaki etkileşimde orta tonlar üzerinde çok az etkisi vardır.
         Genellikle parlaklık, gölge, ve ışık efektleri oluşturmak için kullanılır.is
         */
    }
}


    // MARK: - PREVIEW
#Preview {
    BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradient.ignoresSafeArea(.all))
}
