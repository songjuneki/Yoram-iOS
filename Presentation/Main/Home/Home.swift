//
//  Home.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/10.
//

import SwiftUI

struct Home: View {
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var mainViewModel: MainViewModel
    
    @State private var searchInput: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    Image("Logo")
                        .scaleEffect(0.5)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "bell")
                            .imageScale(.large)
                    }
                    .padding(.horizontal)
                }
                .scaledToFit()
                
                BannerView(banners: self.$homeViewModel.bannerIdList)
                    .frame(height: 250)
                    .padding(.top, 0)
                
                VStack {    // 조직도 검색
                    HStack(alignment: .center) {
                        Text("조직도 검색")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .frame(alignment: .leading)
                        Spacer()
                        Text("전체보기 ❯")
                            .font(.custom("Pretendard-Medium", size: 14))
                            .foregroundColor(Color("PossibleColor"))
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    HStack {
                        Image("Search")
                        
                        Text("이름이나 차 번호를 입력해주세요")
                            .font(.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(Color("HolderGrayColor"))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("ButtonBorderColor"), lineWidth: 1)
                        }
                        .padding(.horizontal)
                    
                        Rectangle()
                        .fill(Color("DividerColor"))
                        .padding(.top)
                }
                
                
                VStack(spacing: 0) {    // 내 정보
                    HStack(spacing: 0) {
                        Text(mainViewModel.loginData.name + " ")
                            .foregroundColor(Color("PossibleColor"))
                            .font(.custom("Pretendard-Bold", size: 18))
                        
                        Text(mainViewModel.loginData.positionName + "님")
                            .font(.custom("Pretendard-SemiBold", size: 18))
                        
                        Spacer()
                        
                        Text("QR코드 체크인")
                            .foregroundColor(Color("ErrorColor"))
                            .font(.custom("Pretendard-Medium", size: 12))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("ErrorColor"), lineWidth: 1)
                            }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .stroke(Color("ButtonBorderColor"), lineWidth: 1)
                            .overlay {
                                VStack(spacing: 5) {
                                    Image("Give")
                                        .padding(.top, 0)
                                        .padding(.bottom, 10)
                                    
                                    Text(mainViewModel.myTotalGive)
                                        .font(.custom("Pretendard-Medium", size: 16))
                                    
                                    Text("이번 달 헌금")
                                        .foregroundColor(Color("TextSubTitleColor"))
                                        .font(.custom("Pretendard-Regular", size: 14))
                                }
                            }
                            .scaledToFit()
                        
                        Rectangle()
                            .stroke(Color("ButtonBorderColor"), lineWidth: 1)
                            .overlay {
                                VStack(spacing: 5) {
                                    Image("Attend")
                                        .padding(.top, 0)
                                        .padding(.bottom, 10)
                                    
                                    HStack(spacing: 0) {
                                        Text("\(mainViewModel.loginData.attendCnt) ")
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        
                                        Text("/ \(mainViewModel.maxWeek)")
                                            .font(.custom("Pretendard-Medium", size: 16))
                                            .foregroundColor(Color("TextSubTitleColor"))
                                    }
                                    
                                    Text("이번 달 출석")
                                        .foregroundColor(Color("TextSubTitleColor"))
                                        .font(.custom("Pretendard-Regular", size: 14))
                                }
                            }
                            .scaledToFit()
                        
                        Rectangle()
                            .stroke(Color("ButtonBorderColor"), lineWidth: 1)
                            .overlay {
                                VStack(spacing: 5) {
                                    Image("MyDepartment")
                                        .padding(.top, 0)
                                        .padding(.bottom, 10)
                                    
                                    Text(mainViewModel.loginData.departmentName ?? "성도")
                                        .font(.custom("Pretendard-Medium", size: 16))
                                    
                                    Text(mainViewModel.loginData.departmentParentName ?? "")
                                        .foregroundColor(Color("TextSubTitleColor"))
                                        .font(.custom("Pretendard-Regular", size: 14))
                                }
                            }
                            .scaledToFit()
                        
                    }
                    .edgesIgnoringSafeArea(.horizontal)
                    
                    Rectangle()
                        .fill(Color("DividerColor"))
                }
                
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        Text("교회 소식")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .frame(alignment: .leading)
                        Spacer()
                        Text("전체보기 ❯")
                            .font(.custom("Pretendard-Medium", size: 14))
                            .foregroundColor(Color("PossibleColor"))
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    // TODO: - 카테고리 수평 스크롤
                    
                    // TODO: - 게시글 수평 스크롤
                }
                
                    
            }
            .padding(.bottom, 100)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .onAppear {
            mainViewModel.getMyLoginData()
            homeViewModel.loadBanners()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(homeViewModel: HomeViewModel(), mainViewModel: MainViewModel())
    }
}
