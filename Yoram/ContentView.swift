//
//  ContentView.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Int = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment:.bottom) {
                TabView(selection: self.$currentTab) {
                    
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    .padding()
                TabBarView(currentTab: self.$currentTab).padding()
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
