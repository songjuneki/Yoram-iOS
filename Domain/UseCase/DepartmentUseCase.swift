//
//  DepartmentUseCase.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/03.
//

import Foundation
import Combine

final class DepartmentUseCase {
    
    func getSimpleUserListByName(_ request: Int) -> AnyPublisher<[SimpleUser], APIError> {
        return UserRepository.instance.requestAllSimpleUserListByName(request)
    }
}

extension String {
    func isKorean() -> Bool {
        return self.range(of: "^[가-힣]{1,}$*", options: .regularExpression) != nil
    }
    
    func getChoseong() -> String {
        if !self.isKorean() {
            return "#"
        }
        
        let CHOSEONG_LIST = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        let GaValue = Int(UnicodeScalar("가").value)
        let firstValue = Int(UnicodeScalar(self.first!.description)!.value)
        
        let index = (firstValue - GaValue) / 588
        
        return CHOSEONG_LIST[index]
    }
}
