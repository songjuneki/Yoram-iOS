//
//  UserDetailView.swift
//  Yoram
//
//  Created by 송준기 on 2023/01/05.
//

import SwiftUI

struct UserDetailView: View {
    @Binding var user: UserDetail
    @StateObject var viewModel: DepartmentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(user.name) \(user.positionName)")
                    .font(.custom("Pretendard-SemiBold", size: 20))
                
                Text("\(user.departmentName)")
                    .font(.custom("Pretendard-Regular", size: 16))
                    .frame(alignment: .bottomLeading)
                
                Spacer()
                
                Image("Call")
                    .shadow(radius: 3)
                    .onTapGesture {
                        self.viewModel.openCallDial(phone: self.user.phone)
                    }
                Image("SMS")
                    .shadow(radius: 3)
                    .onTapGesture {
                        self.viewModel.openSMS(phone: self.user.phone)
                    }
            }
            .padding(.horizontal)
            .background(.white)
            
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    Text("생년월일")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Text("\(user.birth.replacing("-", with: ". "))")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)

                    
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
                
                Group {
                    Text("휴대전화")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .padding(.horizontal)
                    
                    Text("\(user.phone)")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)
                        
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
                
                
                Group {
                    Text("유선전화")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .padding(.horizontal)
                    
                    Text("\(user.tel)")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)
                        
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
                
                Group {
                    Text("주소")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .padding(.horizontal)
                    
                    Text("\(user.address)")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)
                        
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
                
                Group {
                    Text("나머지 주소")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .padding(.horizontal)
                    
                    Text("\(user.addressMore)")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)
                        
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
                
                Group {
                    Text("차량번호")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(Color("PossibleColor"))
                        .padding(.horizontal)
                    
                    Text("\(user.car)")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .padding(.horizontal)
                        
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
            }
            .background(Color("DividerColor"))
            .edgesIgnoringSafeArea(.horizontal)
        }
        .background(.white)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: .constant(UserDetail(id: 98, sex: true, name: "송준기", position: 1050, positionName: "집사", department: 100000, departmentName: "제1남전도회", birth: "1998-01-05", phone: "010-7671-1341", tel: "031-123-4567", address: "경기도 용인시 기흥구", addressMore: "00아파트 1동 2호", car: "12가 1234", avatar: "http://3.39.51.49:8080/api/user/avatar?id=98", permission: 3, appAgreeDate: "", privacyAgreeDate: "")), viewModel: DepartmentViewModel())
    }
}
