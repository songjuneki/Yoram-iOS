//
//  UserRepository.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import Moya
import Alamofire
import CombineMoya
import Combine

class UserRepository {
    static let shared: UserRepository = UserRepository()
    private let provider = MoyaProvider<UserAPI>()
    
    func requestSignUp(_ newUser: NewUser) -> AnyPublisher<Response, MoyaError> {
        return provider.requestPublisher(.SignUp(newUser))
    }
}
