//
//  UserPermission.swift
//  Yoram
//
//  Created by 송준기 on 2023/02/16.
//

import Foundation

enum UserPermission {
    case NONE
    case NORMAL
    case FINANCE
    case PERSONNEL
    case FINANCE_PERSONNEL
    case ADMIN
    case SUPER_ADMIN
}

extension UserPermission {
    static func from(ordinal: Int) -> UserPermission {
        switch ordinal {
        case 0: return .NONE
        case 1: return .NORMAL
        case 2: return .FINANCE
        case 3: return .PERSONNEL
        case 4: return .FINANCE_PERSONNEL
        case 5: return .ADMIN
        case 6: return .SUPER_ADMIN
        default: return .NONE
        }
    }
    
    func ordinal() -> Int {
        switch self {
        case .NONE: return 0
        case .NORMAL: return 1
        case .FINANCE: return 2
        case .PERSONNEL: return 3
        case .FINANCE_PERSONNEL: return 4
        case .ADMIN: return 5
        case .SUPER_ADMIN: return 6
        }
    }
}
