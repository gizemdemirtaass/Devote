//
//  CheckboxStyle.swift
//  Devote
//
//  Created by gizem demirtas on 1.10.2024.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    //Bu kod ile toggle öğesi için gövde oluşturacak yeni bir fonksiyon kurmuş olduk!
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? Color.pink : Color.primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                        
                    }
                    else {
                        playSound(sound: "sound-tap", type: "mp3")
                        
                    }
                }
            configuration.label
        } //: HSTACK
    }
    
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label" , isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
        
    }
}
