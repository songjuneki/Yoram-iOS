//
//  ServerRepository.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/11.
//

import Foundation
import Moya
import Combine

final class ServerRepository {
    static let instance = ServerRepository()
    private let provider = MoyaProvider<ServerAPI>()
    
    func requestServerCheck() -> AnyPublisher<ServerStatus, APIError> {
        return provider.requestPublisher(.Check)
            .map(ServerStatus.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestJusoSearch(_ keyword: String) -> AnyPublisher<[Address], APIError> {
        return provider.requestPublisher(.JusoSerach(keyword))
            .map([Address].self)
            .mapError{ APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestBannerList(_ detail: Bool = false) -> AnyPublisher<[Banner], APIError> {
        return provider.requestPublisher(.BannerList(detail))
            .map([Banner].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestMaxWeek() -> AnyPublisher<Int, APIError> {
        return provider.requestPublisher(.MaxWeek)
            .map(Int.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
}

struct ServerStatus: Codable {
    var status: String
}
