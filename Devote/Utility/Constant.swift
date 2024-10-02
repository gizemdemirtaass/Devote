//
//  Constant.swift
//  Devote
//
//  Created by gizem demirtas on 27.09.2024.
//

import SwiftUI
/*
 itemFormatter
 itemFormatter: Bu bir DateFormatter nesnesidir. timestamp alanını biçimlendirip (tarih ve saat olarak) ekranda gösterir. dateStyle kısa tarih formatını, timeStyle ise orta uzunlukta saat formatını belirler.
 */
// MARK: - FORMATTER
 let itemFormatter: DateFormatter = { //PRIVATE key anahtarını kaldırdık! Her yerden erişim için!
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX
let feedback = UINotificationFeedbackGenerator()
