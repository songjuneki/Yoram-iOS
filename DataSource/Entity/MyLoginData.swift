//
//  MyLoginData.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/23.
//

import Foundation

// MARK: - MyLoginData
struct MyLoginData: Codable, Hashable {
    let id: Int
    let avatar: String?
    let name: String
    let sex: Bool
    let department: Int
    let departmentName: String?
    let departmentParent: Int?
    let departmentParentName: String?
    let position: Int
    let positionName: String
    let permission, attendCnt: Int

    enum CodingKeys: String, CodingKey {
        case id, avatar, name, sex, department
        case departmentName = "department_name"
        case departmentParent = "department_parent"
        case departmentParentName = "department_parent_name"
        case position
        case positionName = "position_name"
        case permission
        case attendCnt = "attend_cnt"
    }
}
