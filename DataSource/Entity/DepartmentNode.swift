//
//  DepartmentNode.swift
//  Yoram
//
//  Created by 송준기 on 2022/12/03.
//

import Foundation

struct DepartmentNode: Hashable, Codable {
    var parent: Int = 0
    var code: Int = 0
    var name: String = ""
    var child: [DepartmentNode] = []
    var users: [SimpleUser] = []
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case parent = "parent"
        case code = "code"
        case name = "name"
        case child = "child"
        case users = "users"
        case isExpanded = "isExpanded"
    }
}

extension DepartmentNode {
    func getCount() -> Int {
        var count = 0
        
        count += self.users.count
        child.forEach { node in
            count += node.getCount()
        }
        
        return count
    }
}
