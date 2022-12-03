//
//  ViewExtension.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/19.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        let scenes = self.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
//        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window?.addGestureRecognizer(tapRecognizer)
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_gestureRecognizer: UITapGestureRecognizer, shouldRecognizeSimultaneouslyWithotherRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}


extension String {
    func highlight(keyword: String) -> String {
        var changed = keyword
        changed.insert(contentsOf: "[", at: changed.startIndex)
        changed.append("](.)")
        return self.replacingOccurrences(of: keyword, with: changed)
    }
}

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style = .systemMaterial) { self.style = style }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

