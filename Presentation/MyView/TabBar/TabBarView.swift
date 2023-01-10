//
//  TabBarView.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace private var namespace
    private let tabList: [String] = ["홈", "조직도", "교인증", "게시판", "내 정보"]
    private let imgList: [String] = ["Home", "Department", "ID", "Board", "My"]
    
    var body: some View {
//        ZStack {
//            HStack(alignment:.center) {
//                ForEach(Array(self.imgList.enumerated()), id: \.0, content: { index, img in
//                    Spacer()
//                    TabBarItem(currentTab: self.$currentTab,
//                               namespace: namespace.self,
//                               img: img,
//                               title: self.tabList[index],
//                               tab: index)
//                    Spacer()
//                })
//            }
//            .zIndex(1)
//
//
//            RoundedRectangle(cornerRadius: 5)
//                .fill(.white)
//                .padding(.vertical, -10)
//                .padding(.bottom, -30)
//                .zIndex(0)
//        }
//        .fixedSize(horizontal: false, vertical: true)
//        .shadow(radius: 5, x: 0, y: 0)
//        .edgesIgnoringSafeArea(.vertical)
        HStack(alignment: .center) {
            ForEach(Array(self.imgList.enumerated()), id: \.0) { index, img in
                Spacer()
                TabBarItem(currentTab: self.$currentTab,
                           namespace: namespace.self,
                           img: img,
                           title: self.tabList[index],
                           tab: index)
                Spacer()
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .shadow(radius: 5)
                .padding(.top, -10)
                .padding(.bottom, -50)
        }
        
    }
    
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    let img: String
    let title: String
    let tab: Int
    
    var body: some View {
        Button {
            withAnimation {
                self.currentTab = tab
            }
            HapticManager.instance.impact(.light)
        } label: {
            VStack(alignment: .center, spacing: 4) {
                if self.currentTab == tab {
                    Image(img)
                        .renderingMode(.template)
                        .foregroundColor(Color("PossibleColor"))
                    
                    Text(title).foregroundColor(Color("PossibleColor")).font(.custom("Pretendard-SemiBold", size: 12))
                } else {
                    Image(img)
                    
                    Text(title).foregroundColor(Color("DisableColor")).font(.custom("Pretendard-Medium", size: 12))
                }
            }
        }.buttonStyle(.plain)
    }
}

struct TabBarView_Preview: PreviewProvider {
    static var previews: some View {
        TabBarView(currentTab: .constant(0))
    }
}
