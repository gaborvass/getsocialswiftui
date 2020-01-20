//
//  ActivitiesListItemView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 20/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI
import GetSocial

struct ActivitiesListItemView: View {

    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    var activity: GetSocialActivityPost

    var onMoreButtonTap: () -> Void

    var onVideoTap: () -> Void
    var onImageTap: () -> Void
    var onLikeTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    RemoteImageView(url: activity.author.avatarUrl, placeholder: "avatar.default-image")
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    VStack(alignment: .leading) {
                        Text(activity.author.displayName).font(.custom("HelveticaNeue-Bold", size: 16.0))
                        Text("\(Date.init(timeIntervalSince1970: Double(activity.createdAt)), formatter: Self.taskDateFormat)").font(.custom("HelveticaNeue", size: 12.0))
                    }
                    Spacer()
                    Button(action: {
                    }) {
                        Image("more-button.bg-image-normal")
                            .resizable()
                            .frame(width: 16, height: 16, alignment: .center)

                    }.onTapGesture {
                        self.onMoreButtonTap()
                    }
                }
                VStack(alignment: .leading) {
                    if activity.videoUrl?.count ?? 0 > 0 {
                            VideoThumbnailView(placeholder: "activity-image.default-image", imageUrl: activity.imageUrl!).frame(maxHeight: 180).onTapGesture {
                                self.onVideoTap()
                            }
                    } else {
                        if activity.imageUrl?.count ?? 0 > 0 {
                            RemoteImageView(url: activity.imageUrl!, placeholder: "activity-image.default-image").frame(maxHeight: 180).aspectRatio(0.4, contentMode: .fill).cornerRadius(2).onTapGesture {
                                self.onImageTap()
                            }
                        }
                    }
                    if activity.text != nil {
                        Text(activity.text!).font(.custom("HelveticaNeue", size: 16.0)).italic()
                    }
                    LikesAndCommentsView(numberOfLikes: activity.likesCount, numberOfComments: activity.commentsCount, isLikedByMe: activity.isLikedByMe, onLikeTap: self.onLikeTap)
                }.padding([.leading, .trailing], 8)
                Divider()
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
        }.onTapGesture {
            
        }

    }
}

//struct ActivitiesListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        //ActivitiesListItemView()
//    }
//}
