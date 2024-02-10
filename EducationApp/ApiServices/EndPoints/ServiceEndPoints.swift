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
    
    case plans
    case purchase_plan
    case plan_transaction
    
    case welcomePopUp
    case welcomeChecklists
    
    case countries
    case timezoneDetails(Int)
    case timezone
    
    case notifications
    case notifications_settings
    case push_notifications(Int, Int)
    
    case posts(String, String, Int, Int)
    case create_post
    case post(Int)
    case post_activity_action
    case report
    case post_by_filter(String, Int, Int)
    case poll_answer
    case post_editor
    case article_editor
    case share_post(Int)
    
    case get_comments(Int, Int, Int)
    case post_comment(Int)
    case delete_comment(Int, Int)
    
    case contact_support
    case cms_pages(String)
    case global_search(String)
    case version_control
    case delete_account(Int)
    
    case member_list(String, Int, Int)
    case member(Int)
    case member_report
    case member_activity_action
    case follower_list(Int, Int)
    case following_list(Int, Int)
    
    case invite_member
    case sent_invite_members(Int, Int)
    
    case events(String, Int, Int)
    case create_event
    case event(Int)
    case event_activity_action
    case event_saved_draft(Int, Int)
    case rsvp_list(Int, String, Int, Int)
    case share_event(Int)
    
    case chat_memberlist(Int, Int)
    case chat_message(Int)
    
    case courses(String, String, Int, Int)
    case course(Int)
    case course_coach_list
    case course_modules(Int)
    case course_module_type(Int, String)
    case user_quiz_answer
    case user_course_activity_update_status
    case course_transaction
    case interactive_workbook_web_url
    case verify_receipt
    case admin_course_view(Int)
    
    case sessions(String, String, Int, Int)
    case session(Int)
    case session_coach_list
    case session_duration(Int)
    case session_transaction
    case stripe_session_payment_initialize(Int, String)
    case calendly_session_web_url
    case one_two_one_session_details(Int, Int)
    case session_detail(Int)
    
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
        case .plans:
            return "plans"
        case .purchase_plan:
            return "purchase_plan"
        case .plan_transaction:
            return "plan_transaction"
        case .welcomePopUp:
            return "welcome_popup"
        case .welcomeChecklists:
            return "welcome_checklists"
        case .countries:
            return "countries"
        case .timezoneDetails((let id)):
            return "time_zone/\(id)"
        case .timezone:
            return "time_zones"
        case .notifications_settings:
            return "change_status"
        case .notifications:
            return "notifications"
        case .push_notifications(let page_index, let page_total):
            return "push_notifications?page=\(page_index)&per_page=\(page_total)"
        case .posts(let post_type, let search_txt, let page_index, let page_total):
            return "posts?post_type=\(post_type)&search_txt=\(search_txt)&page=\(page_index)&per_page=\(page_total)"
        case .create_post:
            return "post"
        case .post(let id):
            return "post/\(id))"
        case .post_activity_action:
            return "post_activity_action"
        case .post_by_filter(let type, let page_index, let page_total):
            return "post_by_filter?type=\(type)&page=\(page_index)&per_page=\(page_total)"
        case .poll_answer:
            return "poll_answer"
        case . post_editor:
            return "editor?post_type=post"
        case .article_editor:
            return "editor?post_type=article"
        case .share_post(let postId):
            return "posts?postId=\(postId)"
        case .report:
            return "report"
        case .get_comments(let id, let page_index, let page_total):
            return "posts/\(id)/post_comments?page=\(page_index)&per_page=\(page_total)"
        case .post_comment(let id):
            return "posts/\(id)/post_comment"
        case .delete_comment(let id, let parent_id):
            return "posts/\(id)/post_comment/\(parent_id)"
        case .contact_support:
            return "contact_support"
        case .cms_pages(let type):
            return "cms_pages?type=\(type)"
        case .global_search(let search):
            return "global_search?term=\(search)"
        case .version_control:
            return "version_control"
        case .delete_account(let id):
            return "user/\(id))"
        case .member_list(let user_type, let page_index, let page_total):
            return "member_list?user_type=\(user_type)&page=\(page_index)&per_page=\(page_total)"
        case .member(let id):
            return "member/\(id))"
        case .member_report:
            return "member_report"
        case .member_activity_action:
            return "member_activity_action"
        case .follower_list(let page_index, let page_total):
            return "follower_list?page=\(page_index)&per_page=\(page_total)"
        case .following_list(let page_index, let page_total):
            return "following_list?page=\(page_index)&per_page=\(page_total)"
        case .invite_member:
            return "invite_member"
        case .sent_invite_members(let page_index, let page_total):
            return "sent_invite_members?page=\(page_index)&per_page=\(page_total)"
        case .events(let event_type, let page_index, let page_total):
            return "events?type=\(event_type)&page=\(page_index)&per_page=\(page_total)"
        case .create_event:
            return "event"
        case .event(let id):
            return "event/\(id))"
        case .event_activity_action:
            return "event_activity_action"
        case .event_saved_draft(let page_index, let page_total):
            return "event_saved_draft?page=\(page_index)&per_page=\(page_total)"
        case .rsvp_list(let id, let attending_type, let page_index, let page_total):
            return "rsvp_list/\(id)?type=\(attending_type)&page=\(page_index)&per_page=\(page_total)"
        case .share_event(let eventId):
            return "events?id=\(eventId)"
        case .chat_memberlist(let page_index, let page_total):
            return "chat_memberlist?page=\(page_index)&per_page=\(page_total)"
        case .chat_message(let id):
            return "chat_message/\(id))"
        case .courses(let type, let device_type, let page_index, let page_total):
            return "courses?type=\(type)&device_type=\(device_type)&page=\(page_index)&per_page=\(page_total)"
        case .course(let id):
            return "course/\(id))"
        case .course_coach_list:
            return "coach_list"
        case .course_modules(let id):
            return "courses/\(id)/course_modules"
        case .course_module_type(let id, let type):
            return "course_module/\(id)?type=\(type)"
        case .user_quiz_answer:
            return "user_quiz_answer"
        case .user_course_activity_update_status:
            return "user_course_activity_update_status"
        case .course_transaction:
            return "course_transaction"
        case . interactive_workbook_web_url:
            return "interactive_workbook_web_url"
        case .verify_receipt:
            return "verifyReceipt"
        case .admin_course_view(let id):
            return "admin/course-view/\(id)"
        case .sessions(let type, let device_type, let page_index, let page_total):
            return "sessions?type=\(type)&device_type=\(device_type)&page=\(page_index)&per_page=\(page_total)"
        case .session(let id):
            return "session/\(id))"
        case .session_coach_list:
            return "coach_list"
        case .session_duration(let id):
            return "session_duration/\(id))"
        case .session_transaction:
            return "session_transaction"
        case .stripe_session_payment_initialize(let id, let device_type):
            return "stripe_session_payment_initialize/\(id)?device_type=\(device_type)"
        case .calendly_session_web_url:
            return "calendly_session_web_url"
        case .one_two_one_session_details(let page_index, let page_total):
            return "one_two_one_session_details?page=\(page_index)&per_page=\(page_total)"
        case .session_detail(let id):
            return "session-detail/\(id)"
        }
    }
}
