// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let name: String
    let pw: String
    let sex: Bool
    let birth: String
    let position: Int
    let department: Int
    let phone: String
    let tel: String
    let carno: String
    let family: Int?
    let address: String
    let addressMore: String
    let permission: Int
    let avatar: String
    let fname: String?
    let lname: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pw = "pw"
        case sex = "sex"
        case birth = "birth"
        case position = "position"
        case department = "department"
        case phone = "phone"
        case tel = "tel"
        case carno = "carno"
        case family = "family"
        case address = "address"
        case addressMore = "address_more"
        case permission = "permission"
        case avatar = "avatar"
        case fname = "fname"
        case lname = "lname"
    }
}
