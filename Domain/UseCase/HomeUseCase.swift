//
//  HomeUseCase.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/24.
//

import Foundation
import Combine

final class HomeUseCase {
    func loadBanners() -> AnyPublisher<[Banner], APIError> {
        return ServerRepository.instance.requestBannerList()
    }
    
}
