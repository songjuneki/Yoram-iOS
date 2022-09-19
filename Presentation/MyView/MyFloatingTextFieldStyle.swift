//
//  UnderlineTextField.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/12.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct MyFloatTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .spaceBetweenTitleText(20) // Sets the space between title and text.
            .textAlignment(.leading) // Sets the alignment for text.
            .lineHeight(1) // Sets the line height.
            .selectedLineHeight(1.5) // Sets the selected line height.
            .lineColor(Color("ButtonBorderColor")) // Sets the line color.
            .selectedLineColor(Color("PossibleColor")) // Sets the selected line color.
            .titleColor(Color("DisableColor")) // Sets the title color.
            .selectedTitleColor(Color("DisableColor")) // Sets the selected title color.
            .titleFont(.custom("Pretendard-Medium", size: 12)) // Sets the title font.
            .textColor(Color("TextTitleColor")) // Sets the text color.
            .selectedTextColor(Color("TextTitleColor")) // Sets the selected text color.
            .textFont(.custom("Pretendard-Medium", size: 16)) // Sets the text font.
            .placeholderColor(Color("DisableColor")) // Sets the placeholder color.
            .placeholderFont(.custom("Pretendard-Medium", size: 16)) // Sets the placeholder font.
            .errorColor(Color("ErrorColor")) // Sets the error color.
            .addDisableEditingAction([]) // Disable text field editing action. Like cut, copy, past, all etc.
            .enablePlaceholderOnFocus(true) // Enable the placeholder label when the textfield is focused.
            .allowsHitTesting(true) // Whether this view participates in hit test operations.
            .disabled(false) // Whether users can interact with this.
    }
}
