//
//  DepartmentSortDropDownMenuView.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/16.
//

import SwiftUI

struct DepartmentSortDropDownMenuView: View {
    @StateObject var mainViewModel: MainViewModel
    @StateObject var viewModel: DepartmentViewModel
    @Binding var showDropDown: Bool
    
    var body: some View {
        VStack {
            Text("이름 순")
                .font(.custom("Pretendard-SemiBold", size: 18))
                .foregroundColor(viewModel.currentSortType == .Name ? Color("TextTitleColor") : Color("DisableColor"))
                .padding(.vertical, 5)
                .onTapGesture {
                    withAnimation {
                        viewModel.currentSortType = .Name
                        self.showDropDown.toggle()
                        viewModel.loadUserList(mainViewModel.loginID)
                    }
                }
            Text("부서 별")
                .font(.custom("Pretendard-SemiBold", size: 18))
                .foregroundColor(viewModel.currentSortType == .Department ? Color("TextTitleColor") : Color("DisableColor"))
                .padding(.vertical, 5)
                .onTapGesture {
                    withAnimation {
                        viewModel.currentSortType = .Department
                        self.showDropDown.toggle()
                        viewModel.loadUserList(mainViewModel.loginID)
                    }
                }
            Text("직분 별")
                .font(.custom("Pretendard-SemiBold", size: 18))
                .foregroundColor(viewModel.currentSortType == .Position ? Color("TextTitleColor") : Color("DisableColor"))
                .padding(.vertical, 5)
                .onTapGesture {
                    withAnimation {
                        viewModel.currentSortType = .Position
                        self.showDropDown.toggle()
                        viewModel.loadUserList(mainViewModel.loginID)
                    }
                }
        }
        .transition(.opacity.combined(with: .scale).animation(.easeIn))
        .padding(.all, 10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .shadow(radius: 5)
        }
        .zIndex(2)
    }
}

struct DepartmentSortDropDownMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentSortDropDownMenuView(mainViewModel: MainViewModel(), viewModel: DepartmentViewModel(), showDropDown: .constant(true))
    }
}
