//
//  ServerAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/11.
//

import Foundation
import Moya

enum ServerAPI {
    case JusoSerach(String)
}

extension ServerAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.base)! }
    
    var path: String {
        switch self {
        case .JusoSerach: return "/juso"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .JusoSerach: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .JusoSerach(let keyword):
            let param = ["keyword": keyword]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}
