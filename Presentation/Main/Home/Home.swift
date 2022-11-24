//
//  Home.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

struct Home: View {
    @StateObject var mainViewModel: MainViewModel
    
    var body: some View {
        Text("Hello \(mainViewModel.loginData.name) \(mainViewModel.loginData.positionName)")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(mainViewModel: MainViewModel())
    }
}
