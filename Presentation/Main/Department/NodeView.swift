//
//  NodeView.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/12.
//

import SwiftUI

struct NodeView: View {
    @State var node: DepartmentNode
    @StateObject var viewModel: DepartmentViewModel
    
    var body: some View {
        ZStack {
            LazyVStack {
                HStack(alignment: .center) {
                    Text("\(node.name)      \(node.getCount())")
                        .font(.custom("Pretendard-Medium", size: 14))
                    
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
                        self.node.isExpanded.toggle()
                    }
                }
                .zIndex(0)
                
                if node.isExpanded {
                    if !node.child.isEmpty {
                        ForEach(Array(self.node.child.enumerated()), id: \.0) { index, child in
                            NodeView(node: child, viewModel: self.viewModel)
                                .padding(.horizontal)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .zIndex(-1)
                        .transition(.opacity.animation(.easeInOut).combined(with: .offset(y:-10).animation(.easeInOut)))
                    }
                    ForEach(node.users, id: \.id) { user in
                        UserCell(user: user, viewModel: self.viewModel)
                            .padding(.horizontal)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .zIndex(-1)
                    .transition(.opacity.animation(.easeInOut).combined(with: .offset(y:-10).animation(.easeInOut)))
                }
            }
        }
    }
    
}
