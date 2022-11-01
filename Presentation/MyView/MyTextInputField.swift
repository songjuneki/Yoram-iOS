//
//  MyTextInputField.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/25.
//

import SwiftUI

struct MyTextInputField: View {
    @State var title: String
    @State var text: String
    @State var hint: String? = nil
    @State var focused: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("TextTitleColor"))
            Text(hint ?? title)
                .foregroundColor(Color("TextHintColor"))
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
        }.padding()
    }
}

struct MyTextInputField_Previews: PreviewProvider {
    static var previews: some View {
        MyTextInputField(title: "타이틀", text: "", hint: "입력")
    }
}
