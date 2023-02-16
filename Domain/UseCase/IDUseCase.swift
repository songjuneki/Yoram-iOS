//
//  IDUseCase.swift
//  Yoram
//
//  Created by 송준기 on 2023/02/10.
//

import Foundation
import Combine
import SwiftUI
import EFQRCode

final class IDUseCase {
    func makeQRCode(uid: Int, date: String, time: String) -> UIImage? {
        let p = "GUSEONGCHURCH;BY.SONGJUNEKI;DATE:\(date);TIME:\(time);ID:\(uid)"
        
        let cipher = Security().AESEncrypt(p)
        
        if let image = EFQRCode.generate(for: cipher, inputCorrectionLevel: .m,
                                         size: EFIntSize.init(width: 300, height: 300),
                                         icon: UIImage(named: "LogoIcon")?.cgImage,
                                         iconSize: .init(width: 300, height: 300)) {
            return UIImage(cgImage: image)
        } else {
            return nil
        }
    }
    
    func makeInvalidQRCode() -> UIImage {
        let p = "GUSEONGCHURCH;BY.SONGJUNEKI;DATE:1998-01-05;TIME:11:11:11;SONGJUENKIJJANG"
        
        let cipher = Security().AESEncrypt(p)
        
        let image = EFQRCode.generate(for: cipher, inputCorrectionLevel: .m,
                                      size: EFIntSize.init(width: 300, height: 300),
                                      icon: UIImage(named: "LogoIcon")?.cgImage,
                                      iconSize: .init(width:300, height: 300))
        
        return UIImage(cgImage: image!)
    }
}
