//
//  MyToggleButton.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/22.
//

import SwiftUI

struct MyToggleButton: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(configuration.isOn ? "ToggleOn" : "ToggleOff")
        }.buttonStyle(PlainButtonStyle())
    }
}
