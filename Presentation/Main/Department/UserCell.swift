//
//  UserCell.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    @State var user: SimpleUser
    @StateObject var viewModel: DepartmentViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: Const.URL.BASE + Const.URL.USER + "/avatar/?id=\(user.id)"))
                .placeholder({ progress in
                    Circle()
                        .fill(.gray)
                        .redacted(reason: .placeholder)
                        .frame(width: 80, height: 80)
                })
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 80, height: 80)))
                .resizing(referenceSize: CGSize(width: 80, height: 80), mode: .aspectFill)
                .mask({
                    Circle()
                })
                .frame(maxWidth: 80, maxHeight: 80)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(user.name) \(user.positionName)")
                    .font(.custom("Pretendard-SemiBold", size: 18))
                Text("\(user.departmentName)")
                    .font(.custom("Pretendard-Regular", size: 16))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .padding(.vertical, 5)
        .onTapGesture {
            self.viewModel.getUserDetail(self.user.id)
        }
    }
}
