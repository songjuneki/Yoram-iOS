// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let address = try? newJSONDecoder().decode(Address.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Address
struct Address: Codable, Hashable {
    let admCd: String
    let bdKdcd: String
    let bdMgtSn: String
    let bdNm: String
    let buldMnnm: String
    let buldSlno: String
    let detBdNmList: String
    let emdNm: String
    let emdNo: String
    let engAddr: String
    let jibunAddr: String
    let liNm: String
    let lnbrMnnm: String
    let lnbrSlno: String
    let mtYn: String
    let rn: String
    let rnMgtSn: String
    let roadAddr: String
    let roadAddrPart1: String
    let roadAddrPart2: String
    let sggNm: String
    let siNm: String
    let udrtYn: String
    let zipNo: String

    enum CodingKeys: String, CodingKey {
        case admCd = "admCd"
        case bdKdcd = "bdKdcd"
        case bdMgtSn = "bdMgtSn"
        case bdNm = "bdNm"
        case buldMnnm = "buldMnnm"
        case buldSlno = "buldSlno"
        case detBdNmList = "detBdNmList"
        case emdNm = "emdNm"
        case emdNo = "emdNo"
        case engAddr = "engAddr"
        case jibunAddr = "jibunAddr"
        case liNm = "liNm"
        case lnbrMnnm = "lnbrMnnm"
        case lnbrSlno = "lnbrSlno"
        case mtYn = "mtYn"
        case rn = "rn"
        case rnMgtSn = "rnMgtSn"
        case roadAddr = "roadAddr"
        case roadAddrPart1 = "roadAddrPart1"
        case roadAddrPart2 = "roadAddrPart2"
        case sggNm = "sggNm"
        case siNm = "siNm"
        case udrtYn = "udrtYn"
        case zipNo = "zipNo"
    }
}
