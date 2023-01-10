//
//  DepartmentAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation
import Moya

enum DepartmentAPI {
    case GetAllDepartments(Int)
    case GetAllDepartmentNodeByPosition(Int)
}

extension DepartmentAPI: TargetType {
    var baseURL: URL { URL(string: Const.URL.BASE + Const.URL.DEPARTMENT)! }
    
    var path: String {
        switch self {
        case .GetAllDepartments: return "/v2/all"
        case .GetAllDepartmentNodeByPosition: return "/v2/pos"
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
        case .GetAllDepartments(let request):
            return .requestParameters(parameters: ["request": request], encoding: URLEncoding.queryString)
        case .GetAllDepartmentNodeByPosition(let request):
            return .requestParameters(parameters: ["request": request], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
}
