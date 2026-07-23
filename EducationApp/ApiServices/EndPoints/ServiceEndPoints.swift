//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation

/// Enum for all API end points
enum APIEndPoint {
    case login
    case register
    case forgot_password
    case update_profile
    case update_password

    case college_get_college_list
    case course_get_course_list(String)
    case get_semester_list(String)
    case get_subject_list(String)
    case get_chapter_list(String)

    case faculties_get_all_faculties
    case faculties_get_faculties_college_wise(String)

    case home_data_get_home_data(Bool, Bool, String)

    var value: String {
        switch self {
        case .login:
            return "auth/login"

        case .register:
            return "auth/register"

        case .forgot_password:
            return "auth/forgot-password"

        case .update_profile:
            return "user/profile"

        case .update_password:
            return "auth/update-password"

        case .college_get_college_list:
            return "college/college-list"

        case .course_get_course_list(let collegeId):
            return "course/course-list?college_id=\(collegeId)"

        case .get_semester_list(let courseId):
            return "semester/semester-list?course_id=\(courseId)"

        case .faculties_get_all_faculties:
            return "faculties/get-faculties"

        case .faculties_get_faculties_college_wise(let collegeId):
            return "faculties/get-faculties-college-wise?college_id=\(collegeId)"

        case .home_data_get_home_data(let getAllPopularCourse, let getAllFaculties, let collegeId):
            return "home-data/get-home-data?getAll_popular_course=\(getAllPopularCourse)&getAll_faculties=\(getAllFaculties)&college_id=\(collegeId)"

        case .get_subject_list(let semesterId):
            return "subject/subject-list?semester_id=\(semesterId)"

        case .get_chapter_list(let subjectId):
            return "chapters/chapter-list?subject_id=\(subjectId)"
        }
    }
}
