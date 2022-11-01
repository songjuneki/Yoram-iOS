//
//  UserCheck.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation

struct LoginCheck: Codable, Identifiable, Equatable {
    var id = UUID()
    
    var name: String
    var pw: String
    var bd: String
    var time = Date()
}
