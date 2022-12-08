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
    @Published var isSearching: Bool = false
    @Published var departmentNodeList: [DepartmentNode] = []
    
    @Published var currentSortType: DepartmentSortType = .Name
    @Published var loadingState: NetworkLoadingState = .loading
    
    
    private let useCase = DepartmentUseCase()
    
    private var subscription = Set<AnyCancellable>()
    
    func loadUserList(_ request: Int) {
        self.loadingState = .loading
        
        switch self.currentSortType {
        case .Name:
            loadUserListByName(request)
        case .Department:
            loadUserListByDepartment(request)
        case .Position:
            loadUserListByName(request)
        }
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
        useCase.getTopDepartmentList()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("DepartmentViewModel::loadUserListByDepartment failure - \(err.message)")
                    self.loadingState = .error
                    return
                case .finished:
                    self.departmentNodeList = []
                }
            } receiveValue: { topList in
                if topList.isEmpty {
                    self.loadingState = .empty
                    return
                }
                topList.forEach { top in
                    var childs: [DepartmentNode] = []
                    var users: [SimpleUser] = []
                    self.getSimpleUserListFromDepartment(department: top.code, request: request) { userResult in
                        users = userResult
                        self.getChildDepartmentList(parent: top.code, request: request) { childResult in
                            childs = childResult
                            self.departmentNodeList.append(DepartmentNode(code: top.code, name: top.name, child: childs, users: users, isExpanded: true))
                        }
                    }
                }
                self.loadingState = .loaded
            }
            .store(in: &subscription)

    }
    
    private func getChildDepartmentList(parent: Int, request: Int, result: @escaping ([DepartmentNode]) -> ()) {
        useCase.getChildDepartmentList(parent)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    result([])
                    return
                }
            } receiveValue: { dptList in
                var list: [DepartmentNode] = []
                dptList.forEach { dpt in
                    var child: [DepartmentNode] = []
                    var users: [SimpleUser] = []
                    self.getChildDepartmentList(parent: dpt.code, request: request) { subResult in
                        child = subResult
                        self.getSimpleUserListFromDepartment(department: dpt.code, request: request) { userResult in
                            users = userResult
                            list.append(DepartmentNode(code: dpt.code, name: dpt.name, child: child, users: users, isExpanded: true))
                        }
                    }
                }
                result(list)
            }
            .store(in: &subscription)

    }
    
    private func getSimpleUserListFromDepartment(department: Int, request: Int, result: @escaping ([SimpleUser]) -> ()) {
        useCase.getUserListFromDepartment(department: department, request: request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    result([])
                    return
                }
            } receiveValue: { users in
                result(users)
            }
            .store(in: &subscription)
    }

    
    init() {
        loadUserList(-1)
    }
}
