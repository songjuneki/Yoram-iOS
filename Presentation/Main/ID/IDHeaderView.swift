//
//  IDHeaderView.swift
//  Yoram
//
//  Created by 송준기 on 2023/02/16.
//

import SwiftUI

struct IDHeaderView: View {
    @StateObject var viewModel: IDViewModel
    @State var permission: UserPermission
    
    var body: some View {
        ZStack {
            HStack {
                Text("교인증")
                    .font(.custom("Pretendard-SemiBold", size: 20))
                    .padding(.vertical)
            }
            
            if self.permission.ordinal() > 2 {
                HStack {
                    Spacer()
                    
                    Image(systemName: "qrcode.viewfinder")
                        .font(.custom("Pretendard-Thin", size: 40))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct IDHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        IDHeaderView(viewModel: IDViewModel(), permission: .ADMIN)
    }
}
