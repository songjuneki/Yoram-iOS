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
                    Home(viewModel: self.viewModel).tag(0)
                    Department().tag(1)
                    ID().tag(2)
                    Board().tag(3)
                    My().tag(4)
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    .padding()
                TabBarView(currentTab: self.$viewModel.currentTab)
                    .padding(.vertical)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
