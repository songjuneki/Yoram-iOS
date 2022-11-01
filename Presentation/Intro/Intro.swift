//
//  NewIntro.swift
//  Yoram
//
//  Created by 송준기 on 2022/10/31.
//

import SwiftUI

struct Intro: View {
    @StateObject var viewModel: IntroViewModel = IntroViewModel()
    
    var body: some View {
        NavigationStack {
            IntroMain(viewModel: self.viewModel)
        }
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro(viewModel: IntroViewModel())
    }
}
