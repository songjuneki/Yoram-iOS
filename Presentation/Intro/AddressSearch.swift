//
//  AddressSearch.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/11.
//

import SwiftUI

struct AddressSearch: View {
    @StateObject var viewModel: IntroViewModel
    @Binding var isShow: Bool
    
    @State private var addrList: [Address] = []
    @State private var testAddrList: [TestAddr] = [
        TestAddr(zipNo: "1234", roadAddr: "경기도 용인시 기흥구 구성로 1", jibunAddr: "구성로 1"),
        TestAddr(zipNo: "5678", roadAddr: "경기도 용인시 기흥구 구성로 2", jibunAddr: "구성로 2"),
        TestAddr(zipNo: "2345", roadAddr: "경기도 용인시 기흥구 구성로 3", jibunAddr: "구성로 3"),
        TestAddr(zipNo: "4566", roadAddr: "경기도 용인시 기흥구 구성로 4", jibunAddr: "구성로 4"),
        TestAddr(zipNo: "4542", roadAddr: "경기도 용인시 기흥구 구성로 5", jibunAddr: "구성로 5"),
        TestAddr(zipNo: "2315", roadAddr: "경기도 용인시 기흥구 구성로 6", jibunAddr: "구성로 6"),
        TestAddr(zipNo: "3523", roadAddr: "경기도 용인시 기흥구 구성로 7", jibunAddr: "구성로 7"),
        TestAddr(zipNo: "3523", roadAddr: "경기도 용인시 기흥구 구성로 8", jibunAddr: "구성로 8"),
        TestAddr(zipNo: "3523", roadAddr: "경기도 용인시 기흥구 구성로 9", jibunAddr: "구성로 9"),
        TestAddr(zipNo: "3523", roadAddr: "경기도 용인시 기흥구 구성로 10", jibunAddr: "구성로 10"),
    ]
    
    @State private var input = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("주소 검색")
                    .font(.custom("Pretendard-Medium", size: 20))
                    .frame(alignment: .center)
                
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        self.isShow = false
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            
            HStack {
                Image("Search")
                
                TextField("도로명 또는 지번을 입력해주세요", text: self.$input)
                    .font(.custom("Pretendard-Regular", size: 16))
                    .lineLimit(1)
                    .onChange(of: self.input) { newValue in
                        viewModel.searchAddress(newValue) { result in
                            addrList = result
                        }
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ButtonBorderColor"), lineWidth: 1)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            Text("예) 도로명(구성로 21), 지번(마북동 370-5)")
                .font(.custom("Pretendard-Regular", size: 14))
                .foregroundColor(Color("PossibleColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Rectangle()
                .foregroundColor(Color("DividerColor"))
                .frame(maxHeight: 8)
                .padding(.vertical, 15)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(addrList, id: \.self) { juso in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(.init(juso.roadAddr.highlight(keyword: self.input)))
                                .font(.custom("Pretendard-Medium", size: 16))
                                .foregroundColor(Color("TextTitleColor"))
                            
                            Text("[지번] " + juso.jibunAddr)
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(Color("TextHintColor"))
                        }
                        .onTapGesture {
                            viewModel.newAddr = juso.roadAddr
                            self.isShow = false
                        }
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
            .frame(minHeight: 400, maxHeight: 600)
        }
        .background(Color.white)
    }
}

struct AddressSearch_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearch(viewModel: IntroViewModel(), isShow: .constant(true))
    }
}

struct TestAddr: Hashable {
    let zipNo: String
    let roadAddr: String
    let jibunAddr: String
}
