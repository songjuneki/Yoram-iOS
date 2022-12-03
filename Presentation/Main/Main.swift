//
//  Main.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct Main: View {
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    @StateObject private var dptViewModel: DepartmentViewModel = DepartmentViewModel()
    
    var body: some View {
        GeometryReader { r in
            //            VStack(alignment: .center, spacing: 0) {
            //                ZStack(alignment: .bottom) {
            //                    TabView(selection: self.$viewModel.currentTab) {
            //                        Home(homeViewModel: self.homeViewModel, mainViewModel: self.viewModel).tag(0)
            //                        Department().tag(1)
            //                        ID().tag(2)
            //                        Board().tag(3)
            //                        My(mainViewModel: self.viewModel).tag(4)
            //                    }.tabViewStyle(.automatic)
            //                        .edgesIgnoringSafeArea(.all)
            //
            //                    TabBarView(currentTab: self.$viewModel.currentTab)
            //                }
            //            }
            //            .edgesIgnoringSafeArea(.vertical)
            //            .onAppear {
            //                self.viewModel.getMyLoginData()
            //            }
            
            ZStack {
                getTabView(currentTab: self.viewModel.currentTab)
                    .transition(.opacity.animation(.easeInOut))
                    .edgesIgnoringSafeArea(.horizontal)
                    
                TabBarView(currentTab: self.$viewModel.currentTab)
                    .position(x: r.size.width/2, y: r.size.height-10)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    private func getTabView(currentTab: Int) -> some View {
        switch currentTab {
        case 0:
            Home(homeViewModel: self.homeViewModel, mainViewModel: self.viewModel)
        case 1:
            DepartmentView(viewModel: self.dptViewModel, mainViewModel: self.viewModel)
        case 2:
            ID()
        case 3:
            Board()
        case 4:
            My(mainViewModel: self.viewModel)
        default:
            Home(homeViewModel: self.homeViewModel, mainViewModel: self.viewModel)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
            Main()
    }
}
