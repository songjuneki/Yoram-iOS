//
//  MyTextInputField.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/25.
//

import SwiftUI

struct MyTextInputField: View {
    let title: String
    @Binding var text: String
    var hint: String? = nil
    @Binding var showError: Bool
    var errorMessage: String = ""
    
    var isSecure: Bool = false
    @FocusState private var isFocused: Bool
    @State private var showText = false
    
    private var tf: TextField<Text> {
        TextField("", text: self.$text)
    }
    
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
                        .offset(y: text.isEmpty ? 0 : -30)
                        .scaleEffect(text.isEmpty ? 1 : 0.75, anchor: .leading)
                }
                
                HStack {
                    if isSecure {
                        if showText {
                            TextField("", text: $text)
                                .autocorrectionDisabled()
                                .lineLimit(1)
                                .focused($isFocused)
                                .frame(maxHeight: 30)
                                .padding(.trailing, 4)
                        } else {
                            SecureField("", text: $text)
                                .autocorrectionDisabled()
                                .lineLimit(1)
                                .focused($isFocused)
                                .frame(maxHeight: 30)
                                .padding(.trailing, 4)
                                .textContentType(.newPassword)
                        }
                        
                        Image(showText ? "HideSecure" : "ShowSecure")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 12)
                            .padding(.trailing, 4)
                            .onTapGesture {
                                showText.toggle()
                            }
                        
                    } else {
                        TextField("", text: $text)
                            .autocorrectionDisabled()
                            .lineLimit(1)
                            .focused($isFocused)
                            .frame(maxHeight: 30)
                            .padding(.trailing, 4)
                    }
                }
                .animation(.linear, value: showText)
                
                
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.3 ), value: !text.isEmpty)
            
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
    
    init(title: String, text: Binding<String>, isSecure: Bool) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
        self._showError = Binding.constant(false)
    }
    
    init(title: String, text: Binding<String>, hint: String, isSecure: Bool, showError: Binding<Bool>, errorMessage: String) {
        self.title = title
        self._text = text
        self.hint = hint
        self.isSecure = isSecure
        self._showError = showError
        self.errorMessage = errorMessage
    }
}



extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            handler(newValue)
        }
    }
}

struct MyTextInputFieldValidation: Identifiable, Hashable {
    static func == (lhs: MyTextInputFieldValidation, rhs: MyTextInputFieldValidation) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(_ condition: Bool, message: String, msgColor: Color) {
        self.condition = condition
        self.message = message
        self.msgColor = msgColor
    }
    
    let condition: Bool
    let message: String
    let msgColor: Color
    var id = UUID()
}
