//
//  IntroLogin.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI


struct IntroLogin: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    
    
    private var backBtn: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image("BackButton")
        }
    }
    
    
    var body: some View {
        GeometryReader { p in
            VStack(alignment:.center) {
                Group {
                    Spacer()
                    Spacer()
                    Image("Logo")
                    Spacer()
                }
                
                Group {
                    FloatingLabelTextField($viewModel.loginName, placeholder: "이름") { state in
                        
                    }.floatingStyle(MyFloatTextFieldStyle())
                        .frame(height: p.size.height/10)

                    FloatingLabelTextField($viewModel.loginPw, placeholder: "비밀번호") { state in
                        
                    }.isSecureTextEntry(true)
                        .floatingStyle(MyFloatTextFieldStyle())
                        .frame(height: p.size.height/10)
                    
                }.padding(.horizontal, 30)
                

                Group {
                    Spacer()
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
                    Spacer()
                    Spacer()
                }
                
                
                Group {
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(!viewModel.loginName.isEmpty && !viewModel.loginPw.isEmpty ? Color("PossibleColor") : Color("DisableColor"))
                            .overlay(Text("시작하기")
                                .foregroundColor(Color.white)
                                .font(.custom("Pretendard-Bold", size: 18)))
                    }.frame(width: p.size.width, height: p.size.height/9, alignment: .center)
                        .disabled(!viewModel.loginName.isEmpty && !viewModel.loginPw.isEmpty ? false : true)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: self.backBtn)
            .navigationBarTitle("로그인")
            .edgesIgnoringSafeArea(.bottom)
            .position(x: p.size.width/2, y: p.size.height/2)
        }
    }
}

struct IntroLogin_Previews: PreviewProvider {
    static var previews: some View {
        IntroLogin(viewModel: IntroViewModel())
    }
}
