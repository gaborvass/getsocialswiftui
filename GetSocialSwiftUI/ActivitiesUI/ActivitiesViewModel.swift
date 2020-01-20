//
//  ActivitiesViewModel.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 20/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import Foundation
import GetSocial

class ActivitiesViewModel: ObservableObject {

    @Published
    var activities: [GetSocialActivityPost] = []

    @Published
    var showActivityIndicator: Bool = false

    @Published
    var postCreated: Bool = false

    func loadInitialData() {
        let query = GetSocialActivitiesQuery.postsForGlobalFeed()
        query.setLimit(20)
        self.loadActivities(query: query)
    }

    func createPost(with text: String, imageAttachment: UIImage?) {
        let content = GetSocialActivityPostContent()
        content.text = text
        if imageAttachment != nil {
            let attachment = GetSocialMediaAttachment.image(imageAttachment!)
            content.mediaAttachment = attachment
        }
        self.showActivityIndicator = true
        GetSocial.postActivity(toGlobalFeed: content, success: { (createdPost) in
            self.showActivityIndicator = false
            self.postCreated = true
            let query = GetSocialActivitiesQuery.postsForGlobalFeed()
            query.setLimit(20)
            self.loadActivities(query: query)
        }, failure: { error in
            self.showActivityIndicator = false
            print("Error: \(error)")
        })
    }

    func likeActivity(_ activity: GetSocialActivityPost) {
        self.showActivityIndicator = true
        GetSocial.likeActivity(withId: activity.activityId, isLiked: !activity.isLikedByMe, success: { updatedPost in
            self.showActivityIndicator = false
        }) { error in
            self.showActivityIndicator = false
            print("Error: \(error)")
        }
    }

    func reportActivity(_ id: String, reason: Int) {
        self.showActivityIndicator = true
        let reason: GetSocialReportingReason = reason == 0 ? .spam : .inappropriateContent
        GetSocial.reportActivity(id, reason: reason, success: {
            self.showActivityIndicator = false
            print("Reported activity")
        }) { error in
            self.showActivityIndicator = false
            print("Failed to report activity, error: \(error)")
        }

    }

    private func loadActivities(query: GetSocialActivitiesQuery) {
        self.showActivityIndicator = true
        GetSocial.activities(with: query, success: { posts in
            self.showActivityIndicator = false
            self.activities = posts
            print("size: \(self.activities.count)")
        }, failure: { error in
            self.showActivityIndicator = false
            print("could not get posts: \(error)")
        })
    }

}

extension GetSocialActivityPost: Identifiable {

}
