//
//  UserAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya

enum UserAPI {
    case Get(name: String, bd: String)
    case SignUp(NewUser)
    case Login(LoginCheck)
    case MyLoginData(Int)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.base + Const.URL.user)! }
    
    var path: String {
        switch self {
        case .Get: return "/find"
        case .SignUp: return "/new"
        case .Login: return "/check"
        case .MyLoginData: return "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Get: return .get
        case .SignUp: return .post
        case .Login: return .post
        case .MyLoginData: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .Get(let name, let bd):
            let param = ["name" : name,
                         "bd" : bd]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .SignUp(let newUser):
            return .requestJSONEncodable(newUser)
        case .Login(let loginData):
            return .requestJSONEncodable(loginData)
        case .MyLoginData(let id):
            return .requestParameters(parameters: ["id" : id], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .Login, .SignUp:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
}