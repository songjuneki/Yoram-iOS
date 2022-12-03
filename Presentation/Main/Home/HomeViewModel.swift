//
//  HomeViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var bannerIdList: [Int] = []
    
    private let useCase = HomeUseCase()
    
    private var subscription = Set<AnyCancellable>()
    
    func loadBanners() {
        useCase.loadBanners()
            .sink { comp in
                switch comp {
                case .failure(_): return
                case .finished: break
                }
            } receiveValue: { list in
                self.bannerIdList = list.compactMap { it in it.id }
            }.store(in: &subscription)
    }
}

