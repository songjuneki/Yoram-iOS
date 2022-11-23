//
//  MainUseCase.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import Foundation
import Alamofire
import Moya
import CombineMoya
import Combine

final class MainUseCase {
    private let userRepository = UserRepository()
    private let serverRepository = ServerRepository()
    
    func getMyLoginData(_ id: Int) -> AnyPublisher<MyLoginData, APIError> {
        return userRepository.requestMyLoginData(id)
    }
}
