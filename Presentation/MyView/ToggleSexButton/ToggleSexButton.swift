//
//  ToggleGroupButton.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/15.
//

import SwiftUI

struct ToggleSexButton: View {
    @Binding var selectedSex: Bool?
    
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            Button {
                if self.selectedSex == true {
                    self.selectedSex = nil
                } else {
                    self.selectedSex = true
                }
            } label: {
                Rectangle()
                    .fill(Color("ButtonColor"))
                    .frame(width: 170, height: 52, alignment: .center)
                    .cornerRadius(5, corners: [.bottomLeft, .topLeft])
                    .foregroundColor(self.selectedSex == true ? Color("PossibleColor") : Color("ButtonColor"))
                    .overlay(
                        Rectangle()
                            .stroke(self.selectedSex == true ? Color("PossibleColor") : Color("ToggleOffColor"), lineWidth: 1)
                            .overlay(Text("남자")
                                .foregroundColor(self.selectedSex == true ? Color("PossibleColor") : Color("DisableColor"))
                                .font(.custom("Pretendard-Medium", size: 16))))
            }
            
            
            Button {
                if self.selectedSex == false {
                    self.selectedSex = nil
                } else {
                    self.selectedSex = false
                }
            } label: {
                Rectangle()
                    .fill(Color("ButtonColor"))
                    .frame(width: 170, height: 52, alignment: .center)
                    .cornerRadius(5, corners: [.bottomRight, .topRight])
                    .foregroundColor(self.selectedSex == false ? Color("PossibleColor") : Color("ButtonColor"))
                    .overlay(
                        Rectangle()
                            .stroke(self.selectedSex == false ? Color("PossibleColor") : Color("ToggleOffColor"), lineWidth: 1)
                            .overlay( Text("여자")
                                .foregroundColor(self.selectedSex == false ? Color("PossibleColor") : Color("DisableColor"))
                                .font(.custom("Pretendard-Medium", size: 16))))
            }
            
        }
    }
}

struct ToggleSexButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleSexButton(selectedSex: .constant(nil))
    }
}
