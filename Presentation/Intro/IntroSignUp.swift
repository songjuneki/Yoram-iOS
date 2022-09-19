//
//  IntroSignUp.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/15.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import ExytePopupView

struct IntroSignUp: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    @State private var isShowPassword = false
    @State private var isShowPasswordValid = false
    @State private var isShowBdPopUp = false
    @State private var tempDate: Date = Date()
    
    private var tfStyle: some FloatingLabelTextFieldStyle {
        MyFloatTextFieldStyle()
    }
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.eraseNewInfo()
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
        VStack(alignment: .center) {
            ScrollView {
                VStack(spacing: 10) {
                    Spacer()
                    Spacer()
                    Spacer()
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
                    }.padding(.horizontal)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FloatingLabelTextField($viewModel.newName, placeholder: "* 이름")
                        .floatingStyle(self.tfStyle)
                        .frame(height: 70)
                        .padding(.horizontal)
                    
                    FloatingLabelTextField($viewModel.newPw, validtionChecker: self.$viewModel.newPwValid , placeholder: "* 비밀번호(영문+숫자 8자 이상)")
                        .addValidation(.init(condition: self.viewModel.newPw.isValid(.password), errorMessage: "영문+숫자 8자 이상 입력해주세요"))
                        .rightView({
                            Button {
                                withAnimation {
                                    self.isShowPassword.toggle()
                                }
                            } label: {
                                Image(self.isShowPassword ? "ShowSecure" : "HideSecure")
                            }.padding(.horizontal, 10)
                        })
                        .isShowError(true)
                        .isSecureTextEntry(!self.isShowPassword)
                        .floatingStyle(self.tfStyle)
                        .frame(height: 70)
                        .padding(.horizontal)
                    
                    FloatingLabelTextField($viewModel.newPwv, validtionChecker: self.$viewModel.newPwvValid, placeholder: "* 비밀번호 확인")
                        .addValidation(.init(condition: self.viewModel.newPw == self.viewModel.newPwv, errorMessage: "비밀번호를 확인해 주세요"))
                        .rightView({
                            Button {
                                withAnimation {
                                    self.isShowPasswordValid.toggle()
                                }
                            } label: {
                                Image(self.isShowPasswordValid ? "ShowSecure" : "HideSecure")
                            }.padding(.horizontal, 10)
                        })
                        .isSecureTextEntry(!self.isShowPasswordValid)
                        .isShowError(true)
                        .floatingStyle(self.tfStyle)
                        .frame(height: 70)
                        .padding(.horizontal)
                    
                    ToggleSexButton(selectedSex: $viewModel.newSex)
                        .padding(.top, 30)
                        .padding(.horizontal)
                    
                    FloatingLabelTextField($viewModel.newBd, placeholder: "* 생년월일")
                        .floatingStyle(self.tfStyle)
                        .disabled(true)
                        .frame(height: 70)
                        .padding(.horizontal)
                        .onTapGesture {
                            self.tempDate = viewModel.newBdDate
                            self.isShowBdPopUp = true
                        }
                    
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(viewModel.isDoneNewInfo() ? Color("PossibleColor") : Color("DisableColor"))
                            .overlay(Text("다음으로")
                                .foregroundColor(Color.white)
                                .font(.custom("Pretendard-Bold", size: 18)))
                    }
                    .frame(height: 70)
                    .padding(.horizontal)
                    .padding(.top, 70)
                    .disabled(viewModel.isDoneNewInfo() ? false : true)
                    
                }
                .frame(maxHeight: .infinity)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: self.backBtn)
                .navigationTitle("회원가입")
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        .popup(isPresented: self.$isShowBdPopUp,
               type: .floater(verticalPadding: 0, useSafeAreaInset: false),
               position: .bottom, dragToDismiss: true, closeOnTapOutside: true,
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
