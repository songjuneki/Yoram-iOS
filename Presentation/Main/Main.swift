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
    @StateObject private var idViewModel: IDViewModel = IDViewModel()
    
    var body: some View {
        GeometryReader { r in
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
            IDView(viewModel: self.idViewModel, mainViewModel: self.viewModel)
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
