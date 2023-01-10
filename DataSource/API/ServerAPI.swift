//
//  ServerAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/11.
//

import Foundation
import Moya

enum ServerAPI {
    case Check
    case JusoSerach(String)
    case BannerList(Bool)
    case GetBanner(Int, Bool)
    case MaxWeek
}

extension ServerAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.BASE)! }
    
    var path: String {
        switch self {
        case .Check: return "/hello"
        case .JusoSerach: return "/juso"
        case .BannerList: return "/banner/list"
        case .GetBanner: return "/banner"
        case .MaxWeek: return "get-max-week"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .Check, .MaxWeek:
            return .requestPlain
        case .JusoSerach(let keyword):
            let param = ["keyword": keyword]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .BannerList(let all):
            return .requestParameters(parameters: ["all": all], encoding: URLEncoding.queryString)
        case .GetBanner(let id, let detail):
            return .requestParameters(parameters: ["id": id, "detail": detail], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}
