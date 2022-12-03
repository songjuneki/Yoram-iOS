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
    func getMyLoginData(_ id: Int) -> AnyPublisher<MyLoginData, APIError> {
        return UserRepository.instance.requestMyLoginData(id)
    }
    
    func getMaxWeek() -> AnyPublisher<Int, APIError> {
        return ServerRepository.instance.requestMaxWeek()
    }
}
