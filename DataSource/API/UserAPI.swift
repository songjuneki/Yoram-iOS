//
//  UserAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya

enum UserAPI {
    case SignUp(NewUser)
    case Login(LoginCheck)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.base + Const.URL.user)! }
    
    var path: String {
        switch self {
        case .SignUp: return "/new"
        case .Login: return "/check"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .SignUp: return .post
        case .Login: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .SignUp(let newUser):
            return .requestJSONEncodable(newUser)
        case .Login(let loginData):
            return .requestJSONEncodable(loginData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
