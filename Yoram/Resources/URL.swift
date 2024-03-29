//
//  URL.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation

extension Const {
    struct URL {
        static let BASE = "http://hyuny840501.cafe24.com:8080/api"
        
        static let USER = "/user"
        static let DEPARTMENT = "/dpt"
        static let POSITION = "/pos"
        static let GIVE = "/give"
        
        static let EMPTY_AVATAR = BASE + USER + "/avatar?id=-1"
    }
}
