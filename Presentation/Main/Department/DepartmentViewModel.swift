//
//  DepartmentViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation
import SwiftUI
import Combine

class DepartmentViewModel: ObservableObject {
    @AppStorage("loginID") var loginID: Int = -1
    
    @Published var isSearching: Bool = false
    @Published var departmentNodeList: [DepartmentNode] = []
    
    @Published var currentSortType: DepartmentSortType = .Name
    @Published var loadingState: NetworkLoadingState = .loading
    
    @Published var isShowUserInfo: Bool = false
    @Published var userInfoLoadingState: NetworkLoadingState = .loading
    @Published var userDetail: UserDetail = UserDetail()
    
    private let useCase = DepartmentUseCase()
    
    private var subscription = Set<AnyCancellable>()
    
    func loadUserList(_ request: Int) {
        self.loadingState = .loading
        self.departmentNodeList.removeAll()
        
        switch self.currentSortType {
        case .Name:
            loadUserListByName(request)
        case .Department:
            loadUserListByDepartment(request)
        case .Position:
            loadUserListByPosition(request)
        }
    }
    
    func openCallDial(phone: String) {
        guard let url = URL(string:"tel:\(phone)") else { return }
        UIApplication.shared.open(url)
    }
    
    func openSMS(phone: String) {
        guard let url = URL(string: "sms:\(phone)") else { return }
        UIApplication.shared.open(url)
    }
    
    
    private func loadUserListByName(_ request: Int) {
        useCase.getSimpleUserListByName(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.message)
                    self.loadingState = .error
                    return
                }
            } receiveValue: { userList in
                var list: [DepartmentNode] = []
                var tempChoseoung = userList.first?.name.getChoseong() ?? "#"
                var nodeCount = 0
                
                list.append(DepartmentNode(code: nodeCount, name: tempChoseoung, child: [], users: [], isExpanded: true))
                
                userList.forEach { user in
                    if tempChoseoung == user.name.getChoseong() {
                        list[nodeCount].users.append(user)
                    } else {
                        nodeCount += 1
                        tempChoseoung = user.name.getChoseong()
                        list.append(DepartmentNode(code: nodeCount, name: tempChoseoung, child: [], users: [], isExpanded: true))
                        list[nodeCount].users.append(user)
                    }
                }
                self.departmentNodeList = list
                self.loadingState = .loaded
                if list.isEmpty {
                    self.loadingState = .empty
                }
            }
            .store(in: &subscription)
    }
    
    private func loadUserListByDepartment(_ request: Int) {
        useCase.getAllDepartmentNodeList(request)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(_):
                    self.loadingState = .error
                    return
                }
            } receiveValue: { result in
                self.departmentNodeList = result
                self.loadingState = .loaded
                if result.isEmpty {
                    self.loadingState = .empty
                }
            }
            .store(in: &subscription)
    }
    
    private func loadUserListByPosition(_ request: Int) {
        useCase.getAllPositionNodeList(request)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(_):
                    self.loadingState = .error
                    return
                }
            } receiveValue: { result in
                self.departmentNodeList = result
                self.loadingState = .loaded
                if result.isEmpty {
                    self.loadingState = .empty
                }
            }
            .store(in: &subscription)
    }
    
    func getUserDetail(_ id: Int) {
        self.userInfoLoadingState = .loading
        self.isShowUserInfo.toggle()
        
        useCase.getUserDetail(id, self.loginID)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let err):
                    self.userInfoLoadingState = .error
                    return
                }
            } receiveValue: { result in
                self.userDetail = result
                self.userInfoLoadingState = .loaded
            }
            .store(in: &subscription)
    }
    
    
    init() {
        loadUserList(-1)
    }
}
