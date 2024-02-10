//
// Copyright (c) 2024 Education App All rights reserved.
//

import Foundation

/// Enum used to check from where user came to CreatePostViewController.
enum enumForCreatePost {
    case post
    case poll
    case article
    case event
}

/// Enum used to check from where user came to enumForActionOnPost.
enum enumForActionOnPost {
    //For Post
    case likePost
    case savePost
    case mutePost
    case sharePost
    case morePost
    case reportPost
    case blockMemberPost
    case reportMemberPost
    case hidePost
    case editPost
    case deletePost
    
    case hidePostFromFeed
    case copyPostId
    case addThisToForPost
    
    //For Member
    case followMember
    case blockMember
    case reportMember
    case removeFromNetwork
    case changeNetworkRole
    
    //For Event
    case calendarViewEvent
    case addToCalendar
    case saveEvent
    case muteEvent
    case shareEvent
    case downloadRSVP
    case duplicateEvent
    case deleteEvent
    case attendingEvent
    
    // For Course
    case promoCode
    case courseCompleted
    case courseImagePreview

    //For Chat
    case blockChat
    case reportChat
    case muteChat
    case enableSoundsChat
    case showSendButtonChat
    case notificationSettingsChat
    
    //For Quiz
    case successQuiz
    
    //For Session
    case payNowSession
    case bookMySession
}

/// Enum used to check from where user came to CreatePostViewController.
enum enumForPost {
    case create
    case edit
    case delete
    case action
    case other
    case comment
}

/// Enum used to check from where user came to PickerController.
enum enumForPickerController {
    case location
    case timezone
}

/// Enum used to check from where user came to enumForEmptyView.
enum enumForEmptyView {
    case emptyView
    case searchView
}

/// Enum used to check from where user came to enumForEmptyHiddenView.
enum enumForEmptyHiddenView {
    case imageView
    case titleView
    case descriptionView
}

/// Enum used to check from where user came to ZoomMeetingOptionsViewController.
enum enumForMeetingOptions {
    case meeting
    case webinar
}

/// Enum used to check from where user came toMoreSettingsViewController.
enum enumForMoreSettings {
    case forPost
    case forMembers
    case forEvents
    case forChat
}

/// Enum used to check from where user came to enumForTermsOfUsePrivacyPolicy.
enum enumForTermsOfUsePrivacyPolicy {
    case termsOfUse
    case privacyPolicy
}

/// Enum used to check from where user came to CreateEventViewController.
enum enumForEvent {
    case createEvent
    case editEvent
    case duplicateEvent
}

/// Enum used to check from where user came to enumForMoreSettings.
enum enumForChat {
    case forChat
    case forGroup
}

/// Enum used to check from where user came to enumForPostType.
enum enumForPostType {
    case savedPost
    case hiddenPost
}

/// Enum used to check from where user came to enumForProfile.
enum enumForProfile {
    case home
    case settings
}

/// Enum used to check from where user came to enumForDatePicker.
enum enumForDatePicker {
    case expirationDate
    case scheduleDate
    case eventStartDate
    case eventEndDate
}

/// Enum used to check from where user came to enumForEventTypes.
enum enumForEventTypes {
    case draftEvent
    case saveEvent
}

/// Enum used to check from where user came to enumForFollowingAndFollowers.
enum enumForFollowingAndFollowers {
    case following
    case followers
}

/// Enum used to check from where user came to enumForCoursesTask.
enum CoursesTask: String {
    case introduction
    case video_lesson
    case audio_recording
    case task
    case quiz
    case reflection_questions
    case reference_link
    case closure_video
}

/// Enum used to check from where user came to enumForInviteMembers.
enum enumForInviteMembers {
    case courses
    case members
    case sessions
}

/// Enum used to check from where user came to enumForViewAllMembers.
enum enumForViewAllMembers {
    case event
    case course
    case session
}

/// Enum used to check from where user came to enumForBookSession.
enum enumForBookSession {
    case success
    case failed
    case cancel
}
