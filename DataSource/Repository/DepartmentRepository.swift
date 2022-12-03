//
//  DepartmentRepository.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation
import Moya
import Combine


final class DepartmentRepository {
    static let instance = DepartmentRepository()
    private let provider = MoyaProvider<DepartmentAPI>()
    
    func requestTopDepartmentList() -> AnyPublisher<[Department], APIError> {
        provider.requestPublisher(.GetTopDepartments)
            .map([Department].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestChildDepartmentList(_ parent: Int) -> AnyPublisher<[Department], APIError> {
        provider.requestPublisher(.GetChildDepartments(parent))
            .map([Department].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestAllDepartmentList() -> AnyPublisher<[Department], APIError> {
        provider.requestPublisher(.GetAllDepartments)
            .map([Department].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
}
