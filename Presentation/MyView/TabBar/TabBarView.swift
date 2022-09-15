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
        HStack(alignment:.center) {
            ForEach(Array(self.imgList.enumerated()), id: \.0, content: { index, img in
                Spacer()
                TabBarItem(currentTab: self.$currentTab,
                           namespace: namespace.self,
                           img: img,
                           title: self.tabList[index],
                           tab: index)
                Spacer()
            })
        }.background(Color.white)
            .edgesIgnoringSafeArea(.all)
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
            self.currentTab = tab
        } label: {
            VStack(alignment: .center, spacing: 4) {
                if self.currentTab == tab {
                    Image("\(img)Blue")
                    Text(title).foregroundColor(Color("PossibleColor")).font(.custom("Pretendard-Medium", size: 12))
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
