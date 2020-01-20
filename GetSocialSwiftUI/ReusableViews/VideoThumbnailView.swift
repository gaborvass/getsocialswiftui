//
//  VideoView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 15/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct VideoThumbnailView: View {

    var placeholder: String
    var imageUrl: String

    var body: some View {
        ZStack {
            RemoteImageView(url: imageUrl, placeholder: placeholder)
            Image(uiImage: UIImage(named: "activity-image.video-play-image")!)
        }
    }
}
