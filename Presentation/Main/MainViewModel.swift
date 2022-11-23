//
//  MainViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    // MARK: - Properties
    @AppStorage("loginID") private var loginID: Int = -1
    
    @Published var currentTab: Int
    @Published var loginData: MyLoginData
    
    private let useCase = MainUseCase()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        self.currentTab = 0
        self.loginData = MyLoginData(id: -1, avatar: "", name: "익명", sex: true, department: 0, departmentName: "성도", departmentParent: 0, departmentParentName: "성도", position: 1050, positionName: "성도", permission: 0, attendCnt: 0)
        getMyLoginData()
    }
    
    private func getMyLoginData() {
        useCase.getMyLoginData(loginID)
            .sink { _ in
            } receiveValue: { result in
                self.loginData = result
            }.store(in: &subscription)
    }
    
}
