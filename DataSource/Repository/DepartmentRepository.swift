//
//  DepartmentRepository.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation
import Moya
import Combine
import CombineMoya


final class DepartmentRepository {
    static let instance = DepartmentRepository()
    private let provider = MoyaProvider<DepartmentAPI>()
    
    func getAllDepartmentNode(_ request: Int) -> AnyPublisher<[DepartmentNode], APIError> {
        return provider.requestPublisher(.GetAllDepartments(request))
            .map([DepartmentNode].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAllDepartmentNodeByPosition(_ request: Int) -> AnyPublisher<[DepartmentNode], APIError> {
        return provider.requestPublisher(.GetAllDepartmentNodeByPosition(request))
            .map([DepartmentNode].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
}
