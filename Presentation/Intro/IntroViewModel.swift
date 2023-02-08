//
//  IntroViewModel.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import Foundation
import Combine
import SwiftUI
import CryptoKit

class IntroViewModel: ObservableObject {
    //MARK: - Properties
    @Published var loginName = ""
    @Published var loginPw = ""
    @Published var loginBd = ""
    
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
    
    @AppStorage("isInit") private var isInit: Bool = false
    @AppStorage("loginID") private var loginID: Int = -1
    
    private let useCase = IntroUseCase()
    
    private var subscription = Set<AnyCancellable>()
    
    
    //MARK: - Functions
    func isValidNewPassword() -> Binding<Bool> {
        let regex: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        if self.newPw.isEmpty {
            return Binding.constant(false)
        } else if self.newPw.range(of: regex, options: .regularExpression) != nil {
            return Binding.constant(false)
        } else {
            return Binding.constant(true)
        }
    }
    
    func isValidNewPaswordValid() -> Binding<Bool> {
        if self.newPwv.isEmpty {
            return Binding.constant(false)
        } else if self.newPw == self.newPwv {
            return Binding.constant(false)
        } else {
            return Binding.constant(true)
        }
    }
    
    func isPhoneValid() -> Binding<Bool> {
        if self.newPhone.isEmpty {
            return Binding.constant(false)
        }
        let validation: Bool = self.newPhone.range(of: "^010-[0-9]{4}-[0-9]{4}$", options: .regularExpression) != nil
        return Binding.constant(!validation)
    }
    
    func isDoneNewInfo() -> Bool {
        var sex: Bool! = false
        if self.newSex != nil {
            sex = true
        }
        return !self.newName.isEmpty && !self.newPw.isEmpty && !self.newPwv.isEmpty && sex && !self.newBd.isEmpty && (self.newPw == self.newPwv)
    }
    
    func isDoneNewInfoAdd() -> Bool {
        var phoneValid = !self.newPhone.isEmpty
        phoneValid = phoneValid && (self.newPhone.range(of: "^010-[0-9]{4}-[0-9]{4}$", options: .regularExpression) != nil)
        return phoneValid && !self.newAddr.isEmpty && !self.newAddrMore.isEmpty
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
        return NewUser(name: newName, pw: newPw.toSHA256(), sex: newSex!, bd: newBd, phone: newPhone, tel: newTel, addr: newAddr, addrMore: newAddrMore, car: newCar)
    }
    
//    func signUp(onSuccess: @escaping () -> (), onFailure: @escaping () -> ()) {
//        let request = userRepository.requestSignUp(makeNewUser())
//
//        request.sink { completion in
//            switch completion {
//            case .finished:
//                print("viewmodel signup finished")
//            case .failure(let error):
//                print("viewmodel signup failure : " + error.localizedDescription)
//                onFailure()
//            }
//        } receiveValue: { response in
//            print("response = " + response.description)
//            guard let result = try? response.map(Int.self) else { onFailure(); return }
//            print("viewmodel signup result=" + result.description)
//            onSuccess()
//        }.store(in: &subscription)
//    }
//
//    func jusoSearch(_ keyword: String) -> [Address] {
//        return serverRepository.requestJusoSearch(keyword)
//    }
//
//    func isAddrInKeyword(dest: String, keyword: String) -> [Int] {
//        var indices = [0, 0]
//
//        let startKeyword = dest.firstIndex(of: keyword.first!)
//        let endKeyword = startKeyword + keyword.count
//
//    }
    
    func signUp(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
        let response = useCase.signUpNewUser(makeNewUser())
        response.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let err):
                print(err.message)
                onFailure()
                return
            }
        } receiveValue: { userId in
            let loginCheck = LoginCheck(id: userId, pw: self.newPwv.toSHA256(), bd: self.newBd)
            self.useCase.login(loginCheck)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        print(err.message)
                        onFailure()
                        return
                    }
                } receiveValue: { isCorrectUser in
                    if isCorrectUser {
                        withAnimation {
                            self.loginID = userId
                            self.isInit = true
                        }
                    } else {
                        onFailure()
                    }
                }.store(in: &self.subscription)
        }.store(in: &subscription)
    }
    
    private func findUser(name: String, success: @escaping ([User]) -> Void, failure: @escaping (LoginFailureType) -> Void) {
        let response = useCase.getUserByName(name: name)
        
        response.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let err):
                print(err.message)
                failure(.SERVER_ERROR)
                return
            }
        } receiveValue: { result in
            success(result)
        }.store(in: &subscription)

    }
    
    func login(success: @escaping (Bool) -> Void, failure: @escaping (LoginFailureType) -> Void) {
        findUser(name: self.loginName) { result in
            if result.isEmpty {
                failure(.NO_USER)
                return
            }
            
            if result.count > 1 {
                failure(.DUPLICATED_NAME)
                return
            }
            
            if !self.loginBd.isEmpty && result.isEmpty {
                failure(.INCORRECT_BD)
                return
            }
            
            let loginCheck = LoginCheck(id: result.first!.id, pw: self.loginPw.toSHA256(), bd: self.loginBd)
            
            self.useCase.login(loginCheck)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        print(loginCheck)
                        print(err.message)
                        failure(.SERVER_ERROR)
                        return
                    }
                } receiveValue: { isLogin in
                    withAnimation {
                        success(isLogin)
                        self.loginID = loginCheck.id
                        self.isInit = true
                    }
                }.store(in: &self.subscription)
        } failure: { failType in
            failure(failType)
        }
    }
    
    func searchAddress(_ keyword: String, success: @escaping ([Address]) -> Void) {
        if !subscription.isEmpty {
            subscription.forEach { c in
                c.cancel()
            }
        }
        
        let response = useCase.queryAddress(keyword)
        
        response.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let err):
                print(err.message)
                return
            }
        } receiveValue: { result in
            success(result)
        }.store(in: &subscription)
    }
}

enum LoginFailureType {
    case NO_USER
    case INCORRECT
    case DUPLICATED_NAME
    case INCORRECT_BD
    case SERVER_ERROR
}

extension String {
    func toSHA256() -> String {
        let data = self.data(using: .utf8)
        return SHA256.hash(data: data!).compactMap { String(format: "%02x", $0) }.joined()
    }
}
