//
//  Department.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct DepartmentView: View {
    @StateObject var viewModel: DepartmentViewModel
    @StateObject var mainViewModel: MainViewModel
    
    @State private var showDropDown = false
    
    var body: some View {
        ZStack {
            GeometryReader { p in
                VStack {
                    HStack {
                        HStack(alignment: .center, spacing: 20) {
                            Text(getSortTypeName(type:viewModel.currentSortType))
                                .font(.custom("Pretendard-SemiBold", size: 20))
                                .coordinateSpace(name: "currentSort")
                            Image(systemName: "chevron.down")
                                .coordinateSpace(name: "arrow")
                        }
                        .frame(alignment: .trailing)
                        .onTapGesture {
                            withAnimation {
                                self.showDropDown.toggle()
                            }
                        }
                        
                        Spacer()
                        
                        Image("Search")
                            .renderingMode(.template)
                            .foregroundColor(Color("TextTitleColor"))
                    }
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation {
                            self.showDropDown = false
                        }
                    }
                    
                    Rectangle()
                        .fill(Color("DividerColor"))
                        .frame(maxHeight: 10)
                        .padding(.top)
                    
                    ScrollView {
                        VStack {
                            ForEach(Array(self.viewModel.departmentNodeList.enumerated()), id: \.0) { index, node in
                                HStack(alignment: .center) {
                                    Text("\(node.name)     \(node.users.count)")
                                        .font(.custom("Pretendard-Medium", size: 12))
                                    Rectangle()
                                        .fill(.white)
                                    
                                    Image(systemName: "chevron.up")
                                        .imageScale(.small)
                                        .foregroundColor(Color("DisableColor"))
                                        .rotationEffect(Angle(degrees: node.isExpanded ? 360 : 180))
                                }
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation {
                                        self.viewModel.departmentNodeList[index].isExpanded.toggle()
                                    }
                                }
                                
                                if node.isExpanded {
                                    ForEach(node.users, id: \.id) { user in
                                        UserCell(user)
                                            .padding(.horizontal)
                                            .transition(.opacity.combined(with: .push(from: .bottom)).animation(.easeIn))
                                            .transition(.asymmetric(insertion: .opacity.combined(with: .push(from: .top)).animation(.easeIn), removal: .opacity.combined(with: .push(from: .bottom)).animation(.easeOut)))
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 100)
                    }
                }
                
                if self.showDropDown {
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
                    .offset(x: 30, y: 30)
                }
            }
        }
        .onTapGesture {
            withAnimation {
                self.showDropDown = false
            }
        }
    }
    
    private func getSortTypeName(type: DepartmentSortType) -> String {
        switch type {
        case .Name:
            return "이름 순"
        case .Department:
            return "부서 별"
        case .Position:
            return "직분 별"
        }
    }
}

enum DepartmentSortType {
    case Name
    case Department
    case Position
}

struct Department_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentView(viewModel: DepartmentViewModel(), mainViewModel: MainViewModel())
    }
}
