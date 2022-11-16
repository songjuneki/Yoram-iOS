//
//  IntroUseCase.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/12.
//

import Foundation
import Alamofire
import Moya
import CombineMoya
import Combine

final class IntroUseCase {
    private let userRepository = UserRepository()
    private let serverRepository = ServerRepository()
    
    
    func getUserByName(name: String) -> AnyPublisher<[User], APIError> {
        return userRepository.requestGetUser(name: name)
    }
    
    func login(_ loginCheck: LoginCheck) -> AnyPublisher<Bool, APIError> {
        return userRepository.requestLogin(loginCheck)
    }
    
    func signUpNewUser(_ newUser: NewUser) -> AnyPublisher<Int, APIError> {
        return userRepository.requestSignUp(newUser)
    }
    
    func queryAddress(_ keyword: String) -> AnyPublisher<[Address], APIError> {
        return serverRepository.requestJusoSearch(keyword)
    }
    
    
}
