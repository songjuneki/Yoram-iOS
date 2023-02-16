//
//  IDViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2023/02/08.
//

import Foundation
import SwiftUI
import Combine
import EFQRCode

class IDViewModel: ObservableObject {
    @AppStorage("loginID") var loginID: Int = -1
    @Published var qr: UIImage
    @Published var isValidQR: Bool = false
    @Published var count: Int = 0
    
    private let useCase: IDUseCase = IDUseCase()
    
    private var timer: Timer? = nil
    
    func makeQRCode() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm:ss"
        
        let now = Date()
        
        if let code = useCase.makeQRCode(uid: self.loginID, date: dateFormat.string(from: now), time: timeFormat.string(from: now)) {
            self.qr = code
            self.countDown()
        } else {
            self.qr = useCase.makeInvalidQRCode()
        }
    }
    
    private func countDown() {
        withAnimation {
            self.isValidQR = true
            self.count = 15
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.count -= 1
            if (self.count < 0) {
                self.stopCount()
            }
        }
    }
    
    func stopCount() {
        self.timer?.invalidate()
        withAnimation {
            self.isValidQR = false
            self.count = 0
        }
    }
    
    init() {
        self.qr = useCase.makeInvalidQRCode()
    }
}
