//
//  ActivityImageView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 16/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct ActivityImageView: View {
    var imageUrl: String

    init(imageURL: String) {
        self.imageUrl = imageURL
    }

    var body: some View {
        ZStack {
            RemoteImageView(url: self.imageUrl, placeholder: "activity-image.default-image")
        }.background(Color.black)
    }
}

