//
//  SwiftUIView.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import SwiftUI

struct KeyboardManagement: ViewModifier {
    @State private var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            offset = keyboardFrame.height - geo.safeAreaInsets.bottom
                        }
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            offset = 0
                        }
                    }
                }
                .padding(.bottom, offset)
        }
    }
}


extension View {
    func keyboardManagement() -> some View {
        self.modifier(KeyboardManagement())
    }
}
