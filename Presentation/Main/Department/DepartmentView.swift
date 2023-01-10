//
//  Department.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI
import Shimmer

struct DepartmentView: View {
    @StateObject var viewModel: DepartmentViewModel
    @StateObject var mainViewModel: MainViewModel
    
    @State private var showDropDown = false
    
    @State private var headerFrame: CGRect = CGRect()
    @State private var headerSafeInset: EdgeInsets = EdgeInsets()
    
    @State private var subExpanded: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        HStack(alignment: .center, spacing: 20) {
                            Text(getSortTypeName(type:self.viewModel.currentSortType))
                                .font(.custom("Pretendard-SemiBold", size: 20))
                            
                            Image(systemName: "chevron.down")
                        }
                        .onTapGesture {
                            withAnimation {
                                self.showDropDown.toggle()
                            }
                        }
                        
                        Rectangle()
                            .fill(.white)
                            .frame(maxHeight: 5)
                        
                        Image("Search")
                            .renderingMode(.template)
                            .foregroundColor(Color("TextTitleColor"))
                    }
                    Rectangle()
                        .fill(Color("DividerColor"))
                        .frame(maxHeight: 10)
                        .padding(.horizontal, -50)
                }
                .frameGetter(self.$headerFrame, self.$headerSafeInset)
                
                if self.showDropDown {
                    HStack {
                        DepartmentSortDropDownMenuView(mainViewModel: self.mainViewModel, viewModel: self.viewModel, showDropDown: self.$showDropDown)
                        Spacer()
                    }
                    .zIndex(2)
                    .offset(y: -30)
                }
            }
            .frame(maxHeight: .infinity, alignment:.topLeading)
            .padding(.horizontal)
            .zIndex(1)
            
            ScrollView {
                switch viewModel.loadingState {
                case .loading: self.placeholder
                case .loaded:
                    LazyVStack {
                        ForEach(self.viewModel.departmentNodeList, id: \.self) {
                            NodeView(node: $0, viewModel: self.viewModel)
                        }
                        Image("LogoWhite")
                            .renderingMode(.template)
                            .colorMultiply(.gray.opacity(0.1))
                            .scaleEffect(0.5)
                            .padding(.vertical)
                    }
                    .padding(.bottom, 100)
                case .empty: self.departmentEmptyView
                case .error: self.departmentEmptyView
                }
            }
            .frame(alignment: .center)
            .offset(y: self.headerFrame.height)
            .padding(.top)
        }
        .onTapGesture {
            withAnimation {
                self.showDropDown = false
            }
        }
        .sheet(isPresented: self.$viewModel.isShowUserInfo) {
            UserInfoView(viewModel: self.viewModel)
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
    
    private var placeholder: some View {
        VStack {
            ForEach(0...10, id: \.self) { _ in
                HStack {
                    Text("head")
                    Text("00")
                    Spacer()
                    Image(systemName: "chevron.up")
                        .imageScale(.small)
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.gray)
                        .frame(maxWidth: 80, maxHeight: 80)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("성이름")
                            Text("직책")
                        }
                        Text("부서부서")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
        .redacted(reason: .placeholder)
        .shimmering()
    }
    
    private var departmentEmptyView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .imageScale(.large)
                .font(.system(size: 100))
                .foregroundColor(Color("TextHintColor"))
            Text("오류가 발생했습니다 다시 시도해주세요")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(Color("TextHintColor"))
        }
    }
}

enum DepartmentSortType {
    case Name
    case Department
    case Position
}

enum NetworkLoadingState {
    case loading
    case loaded
    case empty
    case error
}

struct Department_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentView(viewModel: DepartmentViewModel(), mainViewModel: MainViewModel())
    }
}
