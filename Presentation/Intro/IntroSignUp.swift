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
    
    @State private var isShowBdPopUp = false
    
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
        GeometryReader { p in
            VStack(alignment: .leading) {
                Text("회원가입을 위한")
                    .foregroundColor(Color("TextTitleColor"))
                    .font(.custom("Pretendard-Medium", size: 18))
                HStack(alignment: .center, spacing: 0) {
                    Text("간단한 정보")
                        .foregroundColor(Color("TextTitleColor"))
                        .font(.custom("Pretendard-Medium", size: 18))
                        .bold()
                    Text("를 입력해요!")
                        .foregroundColor(Color("TextTitleColor"))
                        .font(.custom("Pretendard-Medium", size: 18))
                }
            }.padding(.horizontal)
                .padding(.top, 70)

            
            VStack(alignment: .center) {
                Spacer()
                FloatingLabelTextField($viewModel.newName, placeholder: "* 이름")
                    .floatingStyle(self.tfStyle)
                    .frame(height: 70)
                
                FloatingLabelTextField($viewModel.newPw, placeholder: "* 비밀번호(영문+숫자 8자 이상)")
                    .isSecureTextEntry(true)
                    .floatingStyle(self.tfStyle)
                    .frame(height: 70)
                
                
                FloatingLabelTextField($viewModel.newPwv, placeholder: "* 비밀번호 확인")
                    .isSecureTextEntry(true)
                    .floatingStyle(self.tfStyle)
                    .frame(height: 70)
                
                
                ToggleSexButton(selectedSex: $viewModel.newSex)
                    .padding(.top, 30)
                
                
                FloatingLabelTextField($viewModel.newPwv, placeholder: "* 생년월일")
                    .floatingStyle(self.tfStyle)
                    .disabled(true)
                    .frame(height: 70)
                    .onTapGesture {
                        self.isShowBdPopUp = true
                    }.popup(isPresented: self.$isShowBdPopUp, dragToDismiss: true, closeOnTapOutside: true) {
                        bdPicker
                    }
                Spacer()
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: self.backBtn)
            .navigationTitle("회원가입")
            .edgesIgnoringSafeArea(.bottom)
            .padding(.horizontal)
            .position(x: p.size.width/2, y: p.size.height/2)
        }
    }
    
    
    private var bdPicker: some View {
        VStack(alignment: .center, spacing: 10) {
            DatePicker("생년월일 입력", selection: self.$viewModel.newBdDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
        }
    }
}

struct IntroSignUp_Previews: PreviewProvider {
    static var previews: some View {
        IntroSignUp(viewModel: IntroViewModel())
    }
}
