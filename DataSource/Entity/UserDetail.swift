//
//  UserDetail.swift
//  Yoram
//
//  Created by 송준기 on 2023/01/05.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDetail = try? JSONDecoder().decode(UserDetail.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - UserDetail
struct UserDetail: Codable, Hashable {
    var id: Int
    var sex: Bool
    var name: String
    var position: Int
    var positionName: String
    var department: Int
    var departmentName, birth, phone, tel: String
    var address, addressMore, car: String
    var avatar: String
    var permission: Int
    var appAgreeDate, privacyAgreeDate: String

    enum CodingKeys: String, CodingKey {
        case id, sex, name, position
        case positionName = "position_name"
        case department
        case departmentName = "department_name"
        case birth, phone, tel, address
        case addressMore = "address_more"
        case car, avatar, permission
        case appAgreeDate = "app_agree_date"
        case privacyAgreeDate = "privacy_agree_date"
    }
}

extension UserDetail {
    init() {
        self.id = -1
        self.sex = true
        self.name = ""
        self.position = 1050
        self.positionName = ""
        self.department = 100000
        self.departmentName = ""
        self.birth = ""
        self.phone = ""
        self.tel = ""
        self.address = ""
        self.addressMore = ""
        self.car = ""
        self.avatar = ""
        self.permission = 0
        self.appAgreeDate = ""
        self.privacyAgreeDate = ""
    }
}
