//
//  Encrypt.swift
//  Yoram
//
//  Created by 송준기 on 2023/02/08.
//

import Foundation
import CryptoSwift
import CryptoKit

class Security {
    private let `private` = "SJKSJKSJKSJKSJKSJKSJKSJK"
    
    func AESEncrypt(_ plainText: String) -> String {
        do {
            let aes = try AES(key: Array(self.private.utf8), blockMode: ECB(), padding: .pkcs5)
            
            let input = Data(Array(plainText.utf8))
            let encBytes = try aes.encrypt(input.bytes)
            let encData = Data(encBytes)
            return encData.toHexString()
        } catch {
            return "####"
        }
    }
    
    func AESDecrypt(_ cipherText: String) -> String {
        do {
            let aes = try AES(key: Array(self.private.utf8), blockMode: ECB(), padding: .pkcs5)
            
            let decBytes = try aes.decrypt(cipherText.hexaBytes)
            var decrypted = ""
            decBytes.forEach { byte in
                decrypted.append(Character(UnicodeScalar(byte)))
            }
            return decrypted
        } catch {
            return "####"
        }
    }
    
    func toSHA256(_ plain: String) -> String {
        let data = plain.data(using: .utf8)
        return SHA256.hash(data: data!).compactMap { String(format: "%02x", $0) }.joined()
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}
