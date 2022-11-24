//
//  File.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/24.
//

import Foundation
import UIKit

class HapticManager {
    static let instance = HapticManager()
    
    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
