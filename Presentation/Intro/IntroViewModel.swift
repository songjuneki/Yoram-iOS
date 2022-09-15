//
//  IntroViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import Foundation
import Combine

class IntroViewModel: ObservableObject {
    //MARK: - Properties
    
    @Published var loginName = ""
    @Published var loginPw = ""
    
    @Published var newName = ""
    @Published var newPw = ""
    @Published var newPwv = ""
    @Published var newSex: Bool? = nil
    @Published var newBd = ""
    @Published var newBdDate: Date = Date()
    
    func eraseNewInfo() {
        newName = ""
        newPw = ""
        newPwv = ""
        newBd = ""
        newSex = nil
    }
    
}
