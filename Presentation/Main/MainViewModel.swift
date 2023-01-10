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
    private let annonymous = MyLoginData(id: -1, avatar: "", name: "익명", sex: true, department: 0, departmentName: "성도", departmentParent: 0, departmentParentName: "성도", position: 1050, positionName: "성도", permission: 0, attendCnt: 0)
    
    @Published var myTotalGive: String = "10,000원"
    @Published var maxWeek: Int = 5
    
    private let useCase = MainUseCase()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        self.currentTab = 0
        self.loginData = self.annonymous
        getMyLoginData()
        getMaxWeek()
    }
    
    func getMyLoginData() {
        if loginID < 0 {
            self.loginData = annonymous
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
            self.loginData = annonymous
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
