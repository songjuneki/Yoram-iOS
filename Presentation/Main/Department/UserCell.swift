//
//  UserCell.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    private var user: SimpleUser
    
    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: user.avatar))
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
        .padding(.vertical, 5)
    }
}

extension UserCell {
    init(_ user: SimpleUser) {
        self.user = user
        if user.avatar.isEmpty {
            self.user.avatar = Const.URL.BASE + Const.URL.USER + "/avatar?id=-1"
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(SimpleUser(id: -1, name: "송준기", sex: true, position: 1050, positionName: "집사", department: 100000, departmentName: "제1남전도회", avatar: "http://3.39.51.49:8080/api/user/avatar?id=98"))
    }
}
