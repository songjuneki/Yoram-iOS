//
//  IntroViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import Foundation
import Combine
import SwiftUI

class IntroViewModel: ObservableObject {
    //MARK: - Properties
    @Published var path: [any View] = []
    
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
    
    @Published var newPhone = ""
    @Published var newTel = ""
    @Published var newAddr = ""
    @Published var newAddrMore = ""
    @Published var newCar = ""
    
    @Published var isSignUpSuccess = false
    
    let userRepository = UserRepository.shared.self
    
    private var subscription = Set<AnyCancellable>()
    
    
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
    
    func isDoneNewInfoAdd() -> Bool {
        return !self.newPhone.isEmpty && !self.newAddr.isEmpty && !self.newAddrMore.isEmpty
    }
    
    
    func clearNewInfo() {
        newName = ""
        newPw = ""
        newPwv = ""
        newBd = ""
        newSex = nil
    }
    
    func clearNewInfoAdd() {
        newPhone = ""
        newTel = ""
        newAddr = ""
        newAddrMore = ""
        newCar = ""
    }
    
    private func makeNewUser() -> NewUser {
        return NewUser(name: newName, pw: newPw, sex: newSex!, bd: newBd, phone: newPhone, tel: newTel, addr: newAddr, addrMore: newAddrMore, car: newCar)
    }
    
    func signUp(onSuccess: @escaping () -> (), onFailure: @escaping () -> ()) {
        let request = userRepository.requestSignUp(makeNewUser())
        
        request.sink { completion in
            switch completion {
            case .finished:
                print("viewmodel signup finished")
            case .failure(let error):
                print("viewmodel signup failure : " + error.localizedDescription)
                onFailure()
            }
        } receiveValue: { response in
            print("response = " + response.description)
            guard let result = try? response.map(Int.self) else { onFailure(); return }
            print("viewmodel signup result=" + result.description)
            onSuccess()
        }.store(in: &subscription)
    }
}
