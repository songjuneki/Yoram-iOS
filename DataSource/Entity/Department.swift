//
//  Department.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation

// MARK: - Welcome
struct Department: Codable, Hashable {
    var parent: Int? = nil
    var code: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case parent = "parent"
        case code = "code"
        case name = "name"
    }
}
