//
//  BannerView.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/24.
//

import SwiftUI
import SwiftUIPager
import Kingfisher

struct BannerView: View {
    @State private var page: Page = .first()
    @State private var currentIndex = 0
    @Binding var banners: [Int]
    
    var body: some View {
        ZStack {
            
            if banners.isEmpty {
                ProgressView()
            } else {
                Pager(page: page, data: banners, id: \.self) { banner in
                    KFImage.url(URL(string: "\(Const.URL.BASE)/banner?id=\(banner)"))
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                        
                }
                .onPageWillChange({ index in
                    withAnimation {
                        currentIndex = index
                    }
                })
            }
            
            BannerViewIndicator(currentIndex: self.$currentIndex, banners: self.banners)
                .offset(y: 100)
        }
    }
}

struct BannerViewIndicator: View {
    @Binding var currentIndex: Int
    var banners: [Int]
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(Array(self.banners.enumerated()), id: \.0, content: { index, e in
                if currentIndex == index {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PossibleColor"))
                        .frame(maxWidth: 10, maxHeight: 5)
                        .transition(.opacity.animation(.easeInOut))
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("DisableColor"))
                        .frame(maxWidth: 5, maxHeight: 5)
                        .transition(.opacity.animation(.easeInOut))
                }
            })
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(banners: .constant([18, 5, 2]))
    }
}
