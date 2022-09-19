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
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_gestureRecognizer: UITapGestureRecognizer, shouldRecognizeSimultaneouslyWithotherRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
