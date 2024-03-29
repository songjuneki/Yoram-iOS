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
    static let instance = UserRepository()
    private let provider = MoyaProvider<UserAPI>()
    
    func requestGetUser(name: String, bd: String = "") -> AnyPublisher<[User], APIError> {
        return provider.requestPublisher(.Get(name, bd))
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
    
    func requestMyLoginData(_ id: Int) -> AnyPublisher<MyLoginData, APIError> {
        provider.requestPublisher(.MyLoginData(id))
            .map(MyLoginData.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestAllSimpleUserListByName(_ request: Int) -> AnyPublisher<[SimpleUser], APIError> {
        return provider.requestPublisher(.GetUserListByName(request))
            .map([SimpleUser].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestSimpleUserListByDepartment(department: Int, request: Int) -> AnyPublisher<[SimpleUser], APIError> {
        return provider.requestPublisher(.GetUserListByDepartment(department, request))
            .map([SimpleUser].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestSimpleUserListByPosition(position: Int, request: Int) -> AnyPublisher<[SimpleUser], APIError> {
        return provider.requestPublisher(.GetUserListByPosition(position, request))
            .map([SimpleUser].self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }
    
    func requestUserDetail(id: Int, request: Int) -> AnyPublisher<UserDetail, APIError> {
        return provider.requestPublisher(.GetUserDetail(id, request))
            .map(UserDetail.self)
            .mapError { APIError.init(moyaError: $0) }
            .eraseToAnyPublisher()
    }

}
