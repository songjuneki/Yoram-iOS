//
//  DepartmentNode.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/03.
//

import Foundation

struct DepartmentNode: Hashable {
    var parent: Int?
    var code: Int
    var name: String
    var child: [DepartmentNode]
    var users: [SimpleUser]
    var isExpanded: Bool = false
}
