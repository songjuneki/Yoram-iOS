//
//  Main.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct Main: View {
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment:.bottom) {
                TabView(selection: self.$viewModel.currentTab) {
                    Home(mainViewModel: self.viewModel).tag(0)
                    Department().tag(1)
                    ID().tag(2)
                    Board().tag(3)
                    My(mainViewModel: self.viewModel).tag(4)
                }.tabViewStyle(.automatic)
                    .edgesIgnoringSafeArea(.all)
                    .padding()
                
                TabBarView(currentTab: self.$viewModel.currentTab)
                    .padding(.bottom, 15)
                    .zIndex(1)
            }
        }
        .onAppear {
            self.viewModel.getMyLoginData()
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPhone 13 mini", "iPhone Xs"], id: \.self) {
            Main()
                .previewDevice(PreviewDevice(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
