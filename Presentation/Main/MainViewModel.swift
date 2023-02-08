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
    @AppStorage("loginID") var loginID: Int = -1
    @AppStorage("isInit") private var isInit: Bool = true
    
    @Published var currentTab: Int
    @Published var loginData: MyLoginData
    private let anonymous = MyLoginData()
    
    @Published var myTotalGive: String = "10,000원"
    @Published var maxWeek: Int = 5
    
    private let useCase = MainUseCase()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        self.currentTab = 0
        self.loginData = self.anonymous
        getMyLoginData()
        getMaxWeek()
    }
    
    func getMyLoginData() {
        if loginID < 0 {
            self.loginData = anonymous
            return
        }
        
        useCase.getMyLoginData(loginID)
            .sink { _ in
            } receiveValue: { result in
                self.loginData = result
            }.store(in: &subscription)
    }
    
    func logout() {
        withAnimation {
            self.currentTab = 0
            self.loginID = -1
            self.isInit = false
            self.loginData = anonymous
        }
    }
    
    func getMaxWeek() {
        useCase.getMaxWeek()
            .sink { _ in
            } receiveValue: { result in
                self.maxWeek = result
            }.store(in: &subscription)
    }
}
