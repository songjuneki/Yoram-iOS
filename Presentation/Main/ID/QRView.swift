//
//  QRView.swift
//  Yoram
//
//  Created by 송준기 on 2023/01/13.
//

import SwiftUI

struct QRView: View {
    @StateObject var viewModel: IDViewModel
    
    var body: some View {
        ZStack {
            Image(uiImage: self.viewModel.qr)
                .padding(.all)
                .blur(radius: self.viewModel.isValidQR ? 0 : 8)
                .zIndex(1)
            
            VStack {
                Text("QR코드 재발급")
                    .foregroundColor(Color("PossibleColor"))
                    .font(.custom("Pretendard-Medium", size: 18))
                
                Image("ReloadButton")
                    .onTapGesture {
                        self.viewModel.makeQRCode()
                    }
            }
            .zIndex(self.viewModel.isValidQR ? 0 : 2)
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("TintedBlueColor"))
        }
        .transition(.opacity)
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(viewModel: IDViewModel())
    }
}
