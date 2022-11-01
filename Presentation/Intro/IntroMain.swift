//
//  NewIntroMain.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/01.
//

import SwiftUI

struct IntroMain: View {
    @StateObject var viewModel: IntroViewModel
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Image("Logo")
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            
            Group {
                NavigationLink {
                    IntroLogin(viewModel: viewModel)
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("PossibleColor"))
                        .frame(maxHeight: 60, alignment: .center)
                        .overlay(Text("로그인하기")
                            .foregroundColor(Color.white)
                            .font(.custom("Pretendard-Medium", size: 18)))
                        .padding(.horizontal)
                }
                
                NavigationLink {
                    IntroSignUp(viewModel: viewModel)
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .background(Color.white)
                        .foregroundColor(Color("ButtonBorderColor"))
                        .frame(maxHeight: 60, alignment: .center)
                        .overlay(Text("회원가입")
                            .foregroundColor(Color("TextTitleColor"))
                            .font(.custom("Pretendard-Medium", size: 18)))
                        .padding(.horizontal)
                }
                
                Button {
                    // annonymous login
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .background(Color.white)
                        .foregroundColor(Color("ButtonBorderColor"))
                        .frame(maxHeight: 60, alignment: .center)
                        .overlay(Text("비회원 입장하기")
                            .foregroundColor(Color("TextTitleColor"))
                            .font(.custom("Pretendard-Medium", size: 18)))
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Text("로그인에 문제가 있으신가요?")
                .font(.custom("Pretendard-Medium", size: 16))
                .underline()
                .foregroundColor(Color("TextHintColor"))
                .onTapGesture {
                    // help login
                }
            
            Spacer()
        }
        .onAppear {
            viewModel.clearNewInfo()
        }
    }
}

struct IntroMain_Previews: PreviewProvider {
    static var previews: some View {
        IntroMain(viewModel: IntroViewModel())
    }
}
