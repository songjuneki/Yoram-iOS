//
//  NewUser.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation

struct NewUser: Codable {
    var name: String
    var pw: String
    var sex: Bool
    var bd: String
    
    var phone: String
    var tel: String
    var addr: String
    var addrMore: String
    var car: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case pw
        case sex
        case bd = "birth"
        case phone
        case tel
        case car
        case addr = "address"
        case addrMore = "address_more"
    }
}
