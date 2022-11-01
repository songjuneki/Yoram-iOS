//
//  NewIntroSignUpAdd.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import ExytePopupView
import KeyboardAvoider
import Combine
import Moya
import CombineMoya

struct IntroSignUpAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    
    @State private var agreeRule = false
    @State private var agreePrivacy = false
    
    private var tfStyle: some FloatingLabelTextFieldStyle {
        MyFloatTextFieldStyle()
    }
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.clearNewInfoAdd()
        } label: {
            Image("BackButton")
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            Text("추가정보")
                                .foregroundColor(Color("TextTitleColor"))
                                .font(.custom("Pretendard-Medium", size: 18))
                                .bold()
                            Text("를 입력하는")
                                .foregroundColor(Color("TextTitleColor"))
                                .font(.custom("Pretendard-Medium", size: 18))
                        }
                        
                        Text("마지막 단계입니다!")
                            .foregroundColor(Color("TextTitleColor"))
                            .font(.custom("Pretendard-Medium", size: 18))
                    }
                    .padding(.horizontal)
                    .padding(.top, 70)
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Group {
                        FloatingLabelTextField($viewModel.newPhone, placeholder: "* 휴대전화")
                            .floatingStyle(self.tfStyle)
                            .frame(height: 70)
                            .padding(.horizontal)
                        
                        Text("비밀번호를 찾을때 필요하니, 꼭 한번 더 확인해주세요.")
                            .font(.custom("Pretendard-Regular", size: 12))
                            .foregroundColor(Color("PossibleColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        FloatingLabelTextField($viewModel.newTel, placeholder: "유선전화(선택사항)")
                            .floatingStyle(self.tfStyle)
                            .frame(height: 70)
                            .padding(.horizontal)
                        
                        FloatingLabelTextField($viewModel.newAddr, placeholder: "* 주소")
                            .floatingStyle(self.tfStyle)
                            .frame(height: 70)
                            .padding(.horizontal)
                        
                        FloatingLabelTextField($viewModel.newAddrMore, placeholder: "* 나머지 주소")
                            .floatingStyle(self.tfStyle)
                            .frame(height: 70)
                            .padding(.horizontal)
                        
                        FloatingLabelTextField($viewModel.newTel, placeholder: "차량번호(선택사항)")
                            .floatingStyle(self.tfStyle)
                            .frame(height: 70)
                            .padding(.horizontal)
                    }
                    
                    Group {
                        HStack(spacing: 0) {
                            Toggle(isOn: self.$agreeRule, label: {})
                                .toggleStyle(MyToggleButton())
                                .padding(.trailing, 5)
                            Text("이용약관(필수)")
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(Color("PossibleColor"))
                                .underline()
                            Text("에 동의합니다.")
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(Color("DisableColor"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 50)
                        
                        HStack(spacing: 0) {
                            Toggle(isOn: self.$agreePrivacy, label: {})
                                .toggleStyle(MyToggleButton())
                                .padding(.trailing, 5)
                            Text("개인정보 처리방침(필수)")
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(Color("PossibleColor"))
                                .underline()
                            Text("에 동의합니다.")
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(Color("DisableColor"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    backBtn
                }
            }
            .navigationBarTitle("회원가입")
            
            Button {
                viewModel.signUp {
                    print("view success")
                } onFailure: {
                    print("view failure")
                }

            } label: {
                Rectangle()
                    .foregroundColor(viewModel.isDoneNewInfoAdd() && self.agreeRule && self.agreePrivacy ? Color("PossibleColor") : Color("DisableColor"))
                    .overlay(Text("가입완료")
                        .foregroundColor(Color.white)
                        .font(.custom("Pretendard-Bold", size: 18)))
                    .frame(maxHeight: 70)
            }
            .disabled(!viewModel.isDoneNewInfoAdd() && !self.agreeRule && !self.agreePrivacy)
            .edgesIgnoringSafeArea(.bottom)
        }
        .keyboardManagement()
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        .onDisappear {
            viewModel.clearNewInfoAdd()
        }
    }
}


struct IntroSignUpAdd_Previews: PreviewProvider {
    static var previews: some View {
        IntroSignUpAdd(viewModel: IntroViewModel())
    }
}
