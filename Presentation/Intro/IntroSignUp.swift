//
//  NewIntroSignUp.swift
//  Yoram
//
//  Created by 송준기 on 2022/10/31.
//

import SwiftUI
import ExytePopupView
import KeyboardAvoider

struct IntroSignUp: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    @State private var isShowPassword = false
    @State private var isShowPasswordValid = false
    @State private var isShowBdPopUp = false
    @State private var tempDate: Date = Date()
    @State private var isSignUpAddActive: Bool = false
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.clearNewInfo()
        } label: {
            Image("BackButton")
        }
    }
    
    private var dateRange: ClosedRange<Date> {
        let minDateComp = DateComponents(year: 1950, month: 1, day: 1)
        let min = Calendar.current.date(from: minDateComp)
        let max = Date()
        return min!...max
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("회원가입을 위한")
                            .foregroundColor(Color("TextTitleColor"))
                            .font(.custom("Pretendard-Medium", size: 18))
                        HStack(spacing: 0) {
                            Text("간단한 정보")
                                .foregroundColor(Color("TextTitleColor"))
                                .font(.custom("Pretendard-Medium", size: 18))
                                .bold()
                            Text("를 입력해요!")
                                .foregroundColor(Color("TextTitleColor"))
                                .font(.custom("Pretendard-Medium", size: 18))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 70)
                    .padding(.horizontal)
                    
                    
                    MyTextInputField(title: "이름", text: $viewModel.newName, hint: "* 이름")
                        .frame(maxHeight: 70)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    
                    
                    MyTextInputField(title: "비밀번호", text: $viewModel.newPw, hint: "* 비밀번호(영문+숫자 8자 이상)", isSecure: true, showError: viewModel.isValidNewPassword(), errorMessage: "영문+숫자 8자 이상 입력해주세요")
                    .frame(maxHeight: 70)
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    
                    MyTextInputField(title: "비밀번호 확인", text: $viewModel.newPwv, hint: "* 비밀번호 확인", isSecure: true, showError: viewModel.isValidNewPaswordValid(), errorMessage: "비밀번호를 확인해 주세요")
                        .frame(maxHeight: 70)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    
                    ToggleSexButton(selectedSex: $viewModel.newSex)
                        .padding(.top, 30)
                        .padding(.horizontal)
                    
                    MyTextInputField(title: "생년월일", text: $viewModel.newBd)
                        .disabled(true)
                        .frame(maxHeight: 70)
                        .padding(.horizontal)
                        .padding(.top, 50)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            self.tempDate = viewModel.newBdDate
                            self.isShowBdPopUp = true
                        }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    backBtn
                }
            }
            .navigationTitle("회원가입")
            
            NavigationLink {
                IntroSignUpAdd(viewModel: self.viewModel)
            } label: {
                Rectangle()
                    .foregroundColor(viewModel.isDoneNewInfo() ? Color("PossibleColor") : Color("DisableColor"))
                    .overlay(Text("다음으로")
                        .foregroundColor(Color.white)
                        .font(.custom("Pretendard-Bold", size: 18)))
                    .frame(maxHeight: 70)
            }
            .disabled(!viewModel.isDoneNewInfo())
            .edgesIgnoringSafeArea(.bottom)
        }
        .keyboardManagement()
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .popup(isPresented: self.$isShowBdPopUp,
               type: .floater(verticalPadding: 0, useSafeAreaInset: false),
               position: .bottom,
        dragToDismiss: true,
        closeOnTapOutside: true,
               backgroundColor: Color.gray.opacity(0.4)) {
            bdPicker
        }
    }
    
    private var bdPicker: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("생년월일 입력")
                .foregroundColor(Color("TextTitleColor"))
                .font(.custom("Pretendard-Medium", size: 18))
                .padding(.top, 10)
            
            
            DatePicker("", selection: self.$tempDate, in: dateRange ,displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .environment(\.locale, Locale.init(identifier: "ko"))
            
            HStack(alignment: .center, spacing: 0) {
                Button {
                    self.isShowBdPopUp = false
                } label: {
                    Rectangle()
                        .frame(maxHeight: 70)
                        .foregroundColor(Color("DisableColor"))
                        .overlay(Text("취소")
                            .foregroundColor(Color.white)
                            .font(.custom("Pretendard-Bold", size: 16)))
                }
                
                Button {
                    self.viewModel.newBdDate = self.tempDate
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    self.viewModel.newBd = dateFormatter.string(from: self.viewModel.newBdDate)
                    self.isShowBdPopUp = false
                } label: {
                    Rectangle()
                        .frame(maxHeight: 70)
                        .foregroundColor(Color("PossibleColor"))
                        .overlay(Text("선택")
                            .foregroundColor(Color.white)
                            .font(.custom("Pretendard-Bold", size: 16)))
                }
                
            }.edgesIgnoringSafeArea(.bottom)
        }.background(Color.white)
            .cornerRadius(5)
    }
}

struct IntroSignUp_Previews: PreviewProvider {
    static var previews: some View {
        IntroSignUp(viewModel: IntroViewModel())
    }
}
