//
//  UserRepository.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya
import Combine

final class UserRepository {
    private let provider = MoyaProvider<UserAPI>()
    
    func requestGetUser(name: String, bd: String = "") -> AnyPublisher<[User], APIError> {
        return provider.requestPublisher(.Get(name: name, bd: bd))
            .map([User].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestLogin(_ loginCheck: LoginCheck) -> AnyPublisher<Bool, APIError> {
        return provider.requestPublisher(.Login(loginCheck))
            .map(Bool.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestSignUp(_ newUser: NewUser) -> AnyPublisher<Int, APIError> {
        provider.requestPublisher(.SignUp(newUser))
            .map(Int.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }

}
