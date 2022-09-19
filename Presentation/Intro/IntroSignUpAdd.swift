//
//  IntroSignUpAdd.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/19.
//

import SwiftUI

struct IntroSignUpAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: IntroViewModel
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                Spacer()
                Spacer()
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
                    
                }.padding(.horizontal)
                    .padding(.top, 70)
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}

struct IntroSignUpAdd_Previews: PreviewProvider {
    static var previews: some View {
        IntroSignUpAdd(viewModel: IntroViewModel())
    }
}
