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
    
    private let useCase = DepartmentUseCase()
    
    private var subscription = Set<AnyCancellable>()
    
    func loadUserList(_ request: Int) {
        switch self.currentSortType {
        case .Name:
            loadUserListByName(request)
        case .Department:
            loadUserListByName(request)
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
            }
            .store(in: &subscription)
    }
    
    init() {
        loadUserList(-1)
    }
}
