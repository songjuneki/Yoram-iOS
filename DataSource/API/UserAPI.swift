//
//  UserAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya

enum UserAPI {
    case Get(String, String)
    case SignUp(NewUser)
    case Login(LoginCheck)
    case MyLoginData(Int)
    
    case GetUserListByName(Int)
    case GetUserListByDepartment(Int, Int)
    case GetUserListByPosition(Int, Int)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.BASE + Const.URL.USER)! }
    
    var path: String {
        switch self {
        case .Get: return "/find"
        case .SignUp: return "/new"
        case .Login: return "/check"
        case .MyLoginData: return "/my"
            
        case .GetUserListByName: return "/name/all"
        case .GetUserListByDepartment: return "/dpt"
        case .GetUserListByPosition: return "/pos/sp"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Get: return .get
        case .SignUp: return .post
        case .Login: return .post
        case .MyLoginData: return .get
        case .GetUserListByName, .GetUserListByDepartment, .GetUserListByPosition: return .get
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
        case .GetUserListByName(let request):
            return .requestParameters(parameters: ["request": request], encoding: URLEncoding.queryString)
        case .GetUserListByDepartment(let dpt, let request):
            return .requestParameters(parameters: ["dpt": dpt, "request": request], encoding: URLEncoding.queryString)
        case .GetUserListByPosition(let pos, let request):
            return .requestParameters(parameters: ["pos": pos, "request": request], encoding: URLEncoding.queryString)
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
