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
    func getUserByName(name: String) -> AnyPublisher<[User], APIError> {
        return UserRepository.instance.requestGetUser(name: name)
    }
    
    func login(_ loginCheck: LoginCheck) -> AnyPublisher<Bool, APIError> {
        return UserRepository.instance.requestLogin(loginCheck)
    }
    
    func signUpNewUser(_ newUser: NewUser) -> AnyPublisher<Int, APIError> {
        return UserRepository.instance.requestSignUp(newUser)
    }
    
    func queryAddress(_ keyword: String) -> AnyPublisher<[Address], APIError> {
        return ServerRepository.instance.requestJusoSearch(keyword)
    }
    
    
}
