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
                GeometryReader { p in
                    KFImage(URL(string: self.user.avatar))
                        .placeholder { progress in
                            ActivityIndicatorView(isVisible: .constant(!progress.isFinished), type: .equalizer(count: 3))
                                .foregroundColor(.accentColor.opacity(0.8))
                                .frame(maxWidth: 100, maxHeight: 100)
                        }
                        .onSuccess({ img in
                            self.backgroundColor = Color(img.image.averageColor ?? .clear)
                        })
                        .resizing(referenceSize: CGSize(width: p.size.width, height: 300), mode: .aspectFit)
                        .position(x: p.size.width/2, y: p.size.height/2)
                        .scaledToFit()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .edgesIgnoringSafeArea(.horizontal)
            .background(self.backgroundColor)
            .scaledToFit()
    }
}
