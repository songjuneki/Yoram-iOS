//
//  ID.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct IDView: View {
    @StateObject var viewModel: IDViewModel
    @StateObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack {
            IDHeaderView(viewModel: self.viewModel, permission: mainViewModel.getPermission())
            
            Spacer()
            
            VStack {
                Text("입장을 위한 QR코드")
                    .font(.custom("Pretendard-SemiBold", size: 18))
                    .padding(.vertical)
                
                Text("이용하시려는 시설의 담당자에게\nQR코드를 보여주세요")
                    .font(.custom("Pretendard-Medium", size: 16))
                    .foregroundColor(Color("DisableColor"))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            QRView(viewModel: self.viewModel)
            
            Spacer()
            
            HStack {
                Text("남은 시간 ")
                    .font(.custom("Pretendard-Semibold", size: 20))
                
                Text("\(String(format: "%02d", self.viewModel.count))초")
                    .font(.custom("Pretendard-Semibold", size: 20))
                    .foregroundColor(Color(self.viewModel.count > 5 ? "TextTitleColor" : "ErrorColor"))
            }
            
            Spacer()
        }
        .onAppear {
            self.viewModel.makeQRCode()
        }
        .onDisappear {
            self.viewModel.stopCount()
        }
        .padding(.bottom, 100)
    }
}

struct IDView_Previews: PreviewProvider {
    static var previews: some View {
        IDView(viewModel: IDViewModel(), mainViewModel: MainViewModel())
    }
}
