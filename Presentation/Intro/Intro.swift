//
//  Intro.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import SwiftUI

struct Intro: View {
    @StateObject private var viewModel = IntroViewModel()
    
    var body: some View {
        NavigationView {
            IntroMain(viewModel: viewModel)
                .navigationTitle("")
        }.navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
