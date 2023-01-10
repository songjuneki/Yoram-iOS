// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let banner = try? newJSONDecoder().decode(Banner.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Banner
struct Banner: Codable, Hashable {
    var id: Int
    var title: String
    var owner: Int
    var path: String
    var link: String
    var order: Int
    var createDate: String
    var createTime: String
    var expire: String
    var show: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case owner = "owner"
        case path = "path"
        case link = "link"
        case order = "order"
        case createDate = "create_date"
        case createTime = "create_time"
        case expire = "expire"
        case show = "show"
    }
}
