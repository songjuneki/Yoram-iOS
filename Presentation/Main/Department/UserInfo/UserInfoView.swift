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
    @State private var imageAverageColor: Color = .clear
    
    @State private var avatarFrame: CGRect = CGRect()
    @State private var avatarSafeInset: EdgeInsets = EdgeInsets()
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                GeometryReader { p in
                    Rectangle()
                        .fill(self.imageAverageColor)
                        .overlay {
                            KFImage(URL(string: self.viewModel.userDetail.getAvatarURL()))
                                .placeholder { progress in
                                    ActivityIndicatorView(isVisible: .constant(!progress.isFinished), type: .equalizer(count: 3))
                                        .foregroundColor(.accentColor.opacity(0.8))
                                        .frame(width: 100, height: 100)
                                }
                                .onSuccess { img in
                                    self.imageAverageColor = Color(img.image.averageColor ?? .clear)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .overlay(alignment: .topTrailing, content: {
                            Image("CloseWhite")
                                .renderingMode(.template)
                                .foregroundColor(self.imageAverageColor.isBrightness() ? .black : .white)
                                .padding(.all)
                                .onTapGesture {
                                    self.viewModel.isShowUserInfo.toggle()
                                }
                        })
                        .frame(height: self.calcHeight(defaultHeight: 300, yOffset: p.frame(in: .named("scroll")).minY))
                        .offset(y: p.frame(in: .named("scroll")).minY <= 0 ? 0 : -abs(p.frame(in: .named("scroll")).minY))
                        .frameGetter(self.$avatarFrame, self.$avatarSafeInset)
                }
                
                UserDetailView(user: self.$viewModel.userDetail, viewModel: self.viewModel)
                    .padding(.top, 300)
                    .offset(y: self.avatarFrame.height > 300 ? -abs(300 - self.avatarFrame.height)*0.8 : 0)
                
            }
            .coordinateSpace(name: "scroll")
            .onAppear {
                self.imageAverageColor = .clear
            }
        }
    }

    
    private func calcHeight(defaultHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        if yOffset >= .zero {
            return defaultHeight + (yOffset * 0.8)
        }
        return defaultHeight
    }

}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: DepartmentViewModel())
    }
}
