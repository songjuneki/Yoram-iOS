//
//  MyPhoneNumberInputField.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/11.
//

import SwiftUI
import iPhoneNumberField

struct MyPhoneNumberInputField: View {
    let title: String
    @Binding var text: String
    var hint: String? = nil
    @Binding var showError: Bool
    var errorMessage: String = ""
    
    @FocusState private var isFocused: Bool
    @State private var showText = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                if hint != nil {
                    Text(text.isEmpty ? hint! : title)
                        .foregroundColor(text.isEmpty ? Color(.placeholderText) : showError ? Color("ErrorColor") : Color("PossibleColor"))
                        .offset(y: text.isEmpty ? 0 : -30)
                        .scaleEffect(text.isEmpty ? 1 : 0.75, anchor: .leading)
                } else {
                    Text(title)
                        .foregroundColor(text.isEmpty ? Color(.placeholderText) : showError ? Color("ErrorColor") : Color("PossibleColor"))
                        .offset(y : text.isEmpty ? 0 : -30)
                        .scaleEffect(text.isEmpty ? 1 : 0.75, anchor: .leading)
                }
                
                HStack {
                    iPhoneNumberField("", text: $text)
                        .flagHidden(true)
                        .flagSelectable(false)
                        .defaultRegion("kr")
                        .prefixHidden(false)
                        .focused($isFocused)
                        .lineLimit(1)
                        .frame(maxHeight: 30)
                        .padding(.trailing, 4)
                }
                
            }
            .animation(.linear, value: showText)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1.0)
                .foregroundColor(self.isFocused ? Color("PossibleColor") : Color(.placeholderText))
                .onTapGesture {
                    isFocused = true
                }
                .animation(.linear, value: isFocused)
            
            Text(showError ? errorMessage : "")
                .font(.custom("Pretendard-Regular", size: 14))
                .foregroundColor(Color("ErrorColor"))
                .frame(height: 15)
                .animation(.linear, value: showError)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.3), value: !text.isEmpty)
    }
    
    init(title: String, text: Binding<String>) {
        self.title = title
        self._text = text
        self._showError = Binding.constant(false)
    }
    
    init(title: String, text: Binding<String>, hint: String) {
        self.title = title
        self._text = text
        self.hint = hint
        self._showError = Binding.constant(false)
    }
    
    init(title: String, text: Binding<String>, hint: String, showError: Binding<Bool>, errorMessage: String) {
        self.title = title
        self._text = text
        self.hint = hint
        self._showError = showError
        self.errorMessage = errorMessage
    }
}

struct MyPhoneNumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        MyPhoneNumberInputField(title: "전화번호", text: .constant(""), hint: "* 전화번호")
    }
}
