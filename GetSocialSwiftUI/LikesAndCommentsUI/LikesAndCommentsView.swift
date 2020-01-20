//
//  LikesAndCommentsView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct LikesAndCommentsView: View {

    var numberOfLikes: Int = 0
    var numberOfComments: Int = 0

    @State
    var isLikedByMe: Bool = false

    var onLikeTap: () -> Void
    
    var body: some View {
        HStack {
            Text("\(numberOfLikes) likes").font(.custom("HelveticaNeue", size: 14.0))
            Text("\(numberOfComments) comments").font(.custom("HelveticaNeue", size: 14.0))
            Spacer()
            Image(systemName: isLikedByMe ? "hand.thumbsup.fill" :  "hand.thumbsup").onTapGesture {
                self.isLikedByMe.toggle()
                self.onLikeTap()
            }
        }
    }
}

struct LikesAndCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        LikesAndCommentsView(onLikeTap: {})
    }
}
