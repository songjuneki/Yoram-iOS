//
//  UserDetailView.swift
//  Yoram
//
//  Created by 송준기 on 2023/01/05.
//

import SwiftUI
import Kingfisher
import ActivityIndicatorView

struct UserInfoView: View {
    @StateObject var viewModel: DepartmentViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                Image("CloseWhite")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.horizontal)
                    .padding(.top)
                    .zIndex(1)
                    .onTapGesture {
                        self.viewModel.isShowUserInfo = false
                    }
                
                UserAvatarView(user: self.$viewModel.userDetail)
                    .scaledToFill()
                    .zIndex(0)
            }
            
            UserDetailView(user: self.$viewModel.userDetail)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: DepartmentViewModel())
    }
}
