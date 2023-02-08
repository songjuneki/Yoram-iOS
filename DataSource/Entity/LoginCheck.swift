//
//  UserCheck.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation

struct LoginCheck: Codable {
    var id: Int
    var pw: String
    var bd: String
    var time = Date()
}
