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
    
    @Published var newPwValid = false
    @Published var newPwvValid = false
    
    
    //MARK: - Functions
    func isValidNewPassword() -> Bool {
        let regex: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        if self.newPw.isEmpty {
            return false
        } else if self.newPw.range(of: regex, options: .regularExpression) != nil {
            return false
        } else {
            return true
        }
    }
    
    func isValidNewPaswordValid() -> Bool {
        if self.newPwv.isEmpty {
            return false
        } else if self.newPw == self.newPwv {
            return false
        } else {
            return true
        }
    }
    
    func isDoneNewInfo() -> Bool {
        var sex: Bool! = false
        
        if self.newSex != nil {
            sex = true
        }
        
        return !self.newName.isEmpty && !self.newPw.isEmpty && !self.newPwv.isEmpty && sex && !self.newBd.isEmpty && (self.newPw == self.newPwv)
    }
    
    
    func eraseNewInfo() {
        newName = ""
        newPw = ""
        newPwv = ""
        newBd = ""
        newSex = nil
    }
    
}
