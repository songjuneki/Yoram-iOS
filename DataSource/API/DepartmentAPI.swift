//
//  DepartmentAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation
import Moya

enum DepartmentAPI {
    case GetTopDepartments
    case GetChildDepartments(Int)
    case GetAllDepartments
}

extension DepartmentAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.BASE + Const.URL.DEPARTMENT)! }
    
    var path: String {
        switch self {
        case .GetTopDepartments: return "/tops"
        case .GetChildDepartments: return "/has"
        case .GetAllDepartments: return "/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .GetTopDepartments, .GetAllDepartments:
            return .requestPlain
        case .GetChildDepartments(let parent):
            return .requestParameters(parameters: ["parent": parent], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
}
