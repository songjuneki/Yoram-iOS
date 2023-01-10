//
//  SimpleUser.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation

// MARK: - Welcome
struct SimpleUser: Codable, Hashable {
    var id: Int
    var name: String
    var sex: Bool
    var position: Int
    var positionName: String
    var department: Int
    var departmentName: String
    var avatar: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sex = "sex"
        case position = "position"
        case positionName = "position_name"
        case department = "department"
        case departmentName = "department_name"
        case avatar = "avatar"
    }
}
