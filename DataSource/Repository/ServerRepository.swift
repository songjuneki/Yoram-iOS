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
}

struct ServerStatus: Codable {
    var status: String
}
