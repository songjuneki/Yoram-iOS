//
//  NewIntroLogin.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct IntroLogin: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    
    private var tfStyle: some FloatingLabelTextFieldStyle {
        MyFloatTextFieldStyle()
    }
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image("BackButton")
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    Image("Logo")
                        .padding(.vertical, 126)
                    
                    MyTextInputField(title: "이름", text: $viewModel.loginName)
                        .frame(maxHeight: 70)
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                    
                    MyTextInputField(title: "비밀번호", text: $viewModel.loginPw, isSecure: true)
                        .frame(maxHeight: 70)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 30)
                    
                    HStack {
                        Text("비밀번호 찾기")
                            .foregroundColor(Color("TextHintColor"))
                            .font(.custom("Pretendard-Medium", size: 16))
                            .onTapGesture {
                                // 비밀번호 찾기 액션
                            }
                        Text("|")
                            .foregroundColor(Color("TextHintColor"))
                            .font(.custom("Pretendard-Medium", size: 16))
                        Text("회원가입")
                            .foregroundColor(Color("TextHintColor"))
                            .font(.custom("Pretendard-Medium", size: 16))
                            .onTapGesture {
                                // 회원가입 액션
                            }
                    }
                    .padding(.vertical, 64)
                }
            }
            
            Button {
                viewModel.login { isLogin in
                    if isLogin {
                        print("Login Success")
                    } else {
                        print("Login fail - Incorrect user info")
                    }
                } failure: { fail in
                    switch fail {
                    case .NO_USER:
                        print("Login fail - No user")
                    case .INCORRECT:
                        print("Login fail - Incorrect user info")
                    case .DUPLICATED_NAME:
                        print("Login fail - Duplicated name")
                    case .INCORRECT_BD:
                        print("Login fail - Incorrect user BD")
                    case .SERVER_ERROR:
                        print("Login fail - Server Error")
                    }
                }
            } label: {
                Rectangle()
                    .foregroundColor(!viewModel.loginName.isEmpty && !viewModel.loginPw.isEmpty ? Color("PossibleColor") : Color("DisableColor"))
                    .overlay(Text("시작하기")
                        .foregroundColor(Color.white)
                        .font(.custom("Pretendard-Bold", size: 18)))
                    .frame(maxHeight: 80)
            }
            .disabled(!viewModel.loginName.isEmpty && !viewModel.loginPw.isEmpty ? false : true)
            .edgesIgnoringSafeArea(.bottom)
        }
        .keyboardManagement()
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                backBtn
            }
        }
        .navigationTitle("로그인")
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        .onDisappear {
            viewModel.loginName = ""
            viewModel.loginPw = ""
        }
    }
}

struct IntroLogin_Previews: PreviewProvider {
    static var previews: some View {
        IntroLogin(viewModel: IntroViewModel())
    }
}
