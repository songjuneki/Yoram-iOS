//
//  My.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import SwiftUI

struct My: View {
    @AppStorage("isInit") private var isInit: Bool = true
    @AppStorage("loginID") private var loginID: Int = -1
    
    var body: some View {
        VStack {
            Text("Hello, My")
            Button {
                self.isInit = false
                self.loginID = -1
            } label: {
                Text("로그아웃")
            }

        }
    }
}

struct My_Previews: PreviewProvider {
    static var previews: some View {
        My()
    }
}
