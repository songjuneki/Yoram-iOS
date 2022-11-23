//
//  NewIntroSignUpAdd.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import Foundation
import SwiftUI
import iPhoneNumberField
import KeyboardAvoider
import ExytePopupView

struct IntroSignUpAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    
    @State private var agreeRule = false
    @State private var agreePrivacy = false
    
    @State private var showAddressSearch: Bool = false
    @State private var addrKeyword = ""
    @State private var addrList: [Address] = []
    
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.clearNewInfoAdd()
        } label: {
            Image("BackButton")
        }
    }
    
    var body: some View {
        ZStack {
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
                            MyPhoneNumberInputField(title: "휴대전화", text: $viewModel.newPhone, hint: "* 휴대전화", showError: viewModel.isPhoneValid(), errorMessage: "휴대전화 형식이 아닙니다")
                                .frame(maxHeight: 70)
                                .padding(.horizontal)
                            
                            
                            Text("비밀번호를 찾을때 필요하니, 꼭 한번 더 확인해주세요.")
                                .font(.custom("Pretendard-Regular", size: 12))
                                .foregroundColor(Color("PossibleColor"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            MyPhoneNumberInputField(title: "유선전화(선택사항)", text: $viewModel.newTel)
                                .frame(maxHeight: 70)
                                .padding(.horizontal)
                                .padding(.top, 30)
                            
                            MyTextInputField(title: "주소", text: $viewModel.newAddr, hint: "* 주소")
                                .disabled(true)
                                .frame(maxHeight: 70)
                                .padding(.horizontal)
                                .padding(.top, 15)
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                    showAddressSearch = true
                                }
                            
                            MyTextInputField(title: "나머지 주소", text: $viewModel.newAddrMore, hint: "* 나머지 주소")
                                .frame(maxHeight: 70)
                                .padding(.horizontal)
                                .padding(.top, 15)
                            
                            MyTextInputField(title: "차량번호", text: $viewModel.newCar, hint: "차량번호(선택사항)")
                                .frame(maxHeight: 70)
                                .padding(.horizontal)
                                .padding(.top, 15)
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
                    print("sign up")
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
            .sheet(isPresented: $showAddressSearch) {
                AddressSearch(viewModel: self.viewModel, isShow: $showAddressSearch)
            }
        }
//        .popup(isPresented: $showAddressSearch, type: .floater(verticalPadding: 0, useSafeAreaInset: false), position: .bottom, dragToDismiss: true, closeOnTap: false,
//               closeOnTapOutside: true, backgroundColor: Color.gray.opacity(0.4)) {
//            AddressSearch(viewModel: self.viewModel, isShow: $showAddressSearch)
//        }
    }
    
}


struct IntroSignUpAdd_Previews: PreviewProvider {
    static var previews: some View {
        IntroSignUpAdd(viewModel: IntroViewModel())
    }
}
