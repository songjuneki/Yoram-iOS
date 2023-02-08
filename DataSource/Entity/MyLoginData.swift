//
//  MyLoginData.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import Foundation

// MARK: - MyLoginData
struct MyLoginData: Codable, Hashable {
    var id: Int
    var avatar: String
    var name: String
    var sex: Bool
    var department: Int
    var departmentName: String?
    var departmentParent: Int?
    var departmentParentName: String?
    var position: Int
    var positionName: String
    var permission, attendCnt: Int
    var appAgreeDate, privacyAgreeDate: String

    enum CodingKeys: String, CodingKey {
        case id, avatar, name, sex, department
        case departmentName = "department_name"
        case departmentParent = "department_parent"
        case departmentParentName = "department_parent_name"
        case position
        case positionName = "position_name"
        case permission
        case attendCnt = "attend_cnt"
        case appAgreeDate = "app_agree_date"
        case privacyAgreeDate = "privacy_agree_date"
    }
}

extension MyLoginData {
    init() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.id = -1
        self.avatar = Const.URL.EMPTY_AVATAR
        self.name = "익명"
        self.sex = true
        self.department = 0
        self.position = 1050
        self.positionName = "손님"
        self.permission = 0
        self.attendCnt = 0
        self.appAgreeDate = dateFormat.string(from: Date())
        self.privacyAgreeDate = dateFormat.string(from: Date())
    }
}
