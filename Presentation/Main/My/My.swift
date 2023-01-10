//
//  My.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct My: View {
    @StateObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack {
            Text("Hello, My")
            Button {
                mainViewModel.logout()
            } label: {
                Text("로그아웃")
            }

        }
    }
}

struct My_Previews: PreviewProvider {
    static var previews: some View {
        My(mainViewModel: MainViewModel())
    }
}
