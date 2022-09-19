//
//  IntroMain.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import SwiftUI

struct IntroMain: View {
    @StateObject var viewModel: IntroViewModel
    
    var body: some View {
        GeometryReader { p in
            VStack(alignment: .center, spacing: 8, content: {
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
                    Spacer()
                    NavigationLink {
                        IntroLogin(viewModel: viewModel)
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("PossibleColor"))
                            .frame(width: p.size.width, height: p.size.height/12, alignment: .center)
                            .overlay(
                                Text("로그인하기")
                                    .foregroundColor(Color.white)
                                    .font(.custom("Pretendard-Medium", size: 18)))
                            
                    }
                    
                    NavigationLink {
                        IntroSignUp(viewModel: viewModel)
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .background(Color.white)
                            .foregroundColor(Color("ButtonBorderColor"))
                            .frame(width: p.size.width, height: p.size.height/12, alignment: .center)
                            .overlay(
                                Text("회원가입")
                                    .foregroundColor(Color("TextTitleColor"))
                                    .font(.custom("Pretendard-Medium", size: 18)))
                    }
                    
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .background(Color.white)
                            .foregroundColor(Color("ButtonBorderColor"))
                            .frame(width: p.size.width, height: p.size.height/12 , alignment: .center)
                            .overlay(
                                Text("비회원 입장하기")
                                    .foregroundColor(Color("TextTitleColor"))
                                    .font(.custom("Pretendard-Medium", size: 18)))
                            
                    }
                    Spacer()
                }
                
                Group {
                    Text("로그인에 문제가 있으신가요?")
                        .font(.custom("Pretendard-Medium", size: 16))
                        .underline()
                        .foregroundColor(Color("TextHintColor"))
                        .onTapGesture {
                            // action
                        }
                    Spacer()
                }
            }).position(x: p.size.width/2, y: p.size.height/2)
        }.padding(.horizontal)
    }
}

struct IntroMain_Previews: PreviewProvider {
    static var previews: some View {
        IntroMain(viewModel: IntroViewModel())
    }
}
