//
//  NavigationGesture.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/15.
//

import Foundation
import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Pretendard-SemiBold", size: 18)!]
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
