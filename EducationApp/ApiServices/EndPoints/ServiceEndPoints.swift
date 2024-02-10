//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation

/// Enum for all API end points
enum APIEndPoint {
    
    case login
    case socialLogin
    case register
    case forgotPassword
    case user(Int)
    case users
    case editUser(Int)
    case logout
    case change_password
    
    var value: String {
        switch self {
        case .login:
            return "login"
        case .socialLogin:
            return "social_login"
        case .register:
            return "register"
        case .forgotPassword:
            return "forgot_password"
        case .user(let id):
            return "user/\(id))"
        case .users:
            return "users"
        case .editUser(let id):
            return "user/\(id)"
        case .logout:
            return "logout"
        case .change_password:
            return "change_password"
        }
    }
}
