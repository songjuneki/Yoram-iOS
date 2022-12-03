//
//  MyBannerView.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/25.
//

import SwiftUI
import Kingfisher

struct MyBannerView: View {
    @State private var currentIndex: Int = 1
    @Binding var banner: [Banner]
    
    var body: some View {
        TabView(selection: self.$currentIndex) {
            ForEach(Array(banner.enumerated()), id: \.element.id) { index, banner in
                KFImage.url(URL(string: "\(Const.URL.BASE)/banner?id=\(banner.id)"))
                    .resizable()
                    .scaledToFit()
                    .tag(index)
            }
        }.tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .gesture(DragGesture()
                .onChanged({ gesture in
                    
                }))
    }
}

struct MyBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MyBannerView(banner: .constant([
            Banner(id: 18, title: "", owner: 0, path: "", link: "", order: 1, createDate: "", createTime: "", expire: "", show: true),
            Banner(id: 5, title: "", owner: 0, path: "", link: "", order: 1, createDate: "", createTime: "", expire: "", show: true),
            Banner(id: 2, title: "", owner: 0, path: "", link: "", order: 1, createDate: "", createTime: "", expire: "", show: true)
        ]))
    }
}
