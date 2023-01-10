//
//  Department.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/01.
//

import Foundation

// MARK: - Welcome
struct Department: Codable, Hashable {
    var parent: Int
    var code: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case parent = "parent"
        case code = "code"
        case name = "name"
    }
}

extension Department {
    func toDepartmentNode() -> DepartmentNode {
        return DepartmentNode(parent: self.parent, code: self.code, name: self.name, isExpanded: true)
    }
}

extension [Department] {
    func toDepartmentNodeList() -> [DepartmentNode] {
        var list: [DepartmentNode] = []
        self.forEach { list.append($0.toDepartmentNode()) }
        return list
    }
}
