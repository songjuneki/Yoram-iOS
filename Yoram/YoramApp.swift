//
//  YoramApp.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

@main
struct YoramApp: App {
//    @State private var isFirstView = true
    @AppStorage("isInit") private var isInit: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isInit {
                    Main()
                        .transition(.opacity.animation(.linear))
                } else {
                    Intro()
                        .transition(.opacity.animation(.linear))
                }
            }
        }
    }
}

//struct FisrtView: View {
//    @Binding var isShowView: Bool
//
//    var body: some View {
//        VStack {
//            Text("First View")
//            Button("Go to Second View") {
//                withAnimation {
//                    isShowView.toggle()
//                }
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.brown)
//    }
//}
//
//struct SecondView: View {
//    @Binding var isShowView: Bool
//
//    var body: some View {
//        VStack {
//            Text("Second View")
//            Button("Go to First View") {
//                withAnimation {
//                    isShowView.toggle()
//                }
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.blue)
//    }
//}
