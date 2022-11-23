//
//  Home.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        Text("Hello \(viewModel.loginData.name) \(viewModel.loginData.positionName)")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: MainViewModel())
    }
}
