//
//  ServiceAPI.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya

enum APIError: Error {
    case requestFail
    case timeout
    case unknownError
    
    var message: String {
        switch self {
        case .requestFail:
            return "요청 실패"
        case .timeout:
            return "타임 아웃"
        case .unknownError:
            return "알 수 없는 오류"
        }
    }
    
    init(moyaError: MoyaError) {
        if let statusCode = moyaError.response?.statusCode {
            switch statusCode {
            case 400...499:
                self = .requestFail
            case 501, 502, 504...599:
                self = .requestFail
            default:
                self = .unknownError
            }
        } else {
            self = .unknownError
        }
    }
}
