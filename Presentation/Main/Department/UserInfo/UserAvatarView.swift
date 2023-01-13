//
//  UserAvatarView.swift
//  Yoram
//
//  Created by 송준기 on 2023/01/05.
//

import SwiftUI
import Kingfisher
import ActivityIndicatorView

struct UserAvatarView: View {
    @Binding var user: UserDetail
    @State private var backgroundColor: Color = .clear
    
    var body: some View {
        ZStack {
            KFImage(URL(string: self.user.avatar))
                .placeholder { progress in
                    ActivityIndicatorView(isVisible: .constant(!progress.isFinished), type: .equalizer(count: 3))
                        .foregroundColor(.accentColor.opacity(0.8))
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                .onSuccess { img in
                    self.backgroundColor = Color(img.image.averageColor ?? .clear)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .background(self.backgroundColor)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarView(user: .constant(UserDetail(id: 98, sex: true, name: "송준기", position: 1050, positionName: "집사", department: 100000, departmentName: "제1남전도회", birth: "1998-01-05", phone: "010-7671-1341", tel: "031-123-4567", address: "경기도 용인시 기흥구", addressMore: "00아파트 1동 2호", car: "12가 1234", avatar: "http://3.39.51.49:8080/api/user/avatar?id=98", permission: 3, appAgreeDate: "", privacyAgreeDate: "")))
    }
}
