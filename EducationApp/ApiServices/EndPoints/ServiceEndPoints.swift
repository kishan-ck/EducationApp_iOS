//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation

/// Enum for all API end points
enum APIEndPoint {
    
    case login
    case register
    case forgotPassword
    case user(Int)
    case users
    case editUser(Int)
    case logout
    case change_password
    
    case college_get_college_list
    case course_get_course_list(String)
    case get_semester_list(String)
    case get_subject_list(String)
    case get_chapter_list(String)
    
    var value: String {
        switch self {
        case .login:
            return "login"
            
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
            
        case .college_get_college_list:
            return "college/get-college-list"
            
        case .course_get_course_list(let collegeId):
            return "course/get-course-list?college_id=\(collegeId)"
            
        case .get_semester_list(let courseId):
            return "semester/get-semester-list?course_id=\(courseId)"
            
        case .get_subject_list(let semesterId):
            return "subject/get-subject-list?semester_id=\(semesterId)"
            
        case .get_chapter_list(let subjectId):
            return "chapters/chapter-list?subject_id=\(subjectId)"
        }
    }
}
