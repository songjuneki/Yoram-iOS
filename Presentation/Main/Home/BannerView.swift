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
    private var banners = Array(0...5)
    
    var body: some View {
        Pager(page: page, data: banners, id: \.self) { banner in
            Text("banner\(banner)")
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
