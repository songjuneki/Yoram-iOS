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
    
    
    func requestJusoSearch(_ keyword: String) -> AnyPublisher<[Address], APIError> {
        return provider.requestPublisher(.JusoSerach(keyword))
            .map([Address].self)
            .mapError{ APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
}
