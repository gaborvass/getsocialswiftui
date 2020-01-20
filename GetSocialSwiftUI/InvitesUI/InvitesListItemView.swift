//
//  InvitesListItemView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI

struct InvitesListItemView: View {

    var iconUrl: String
    var channelName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 8) {
                RemoteImageView(url: iconUrl, placeholder: "facebook").frame(width: 38, height: 38)
                Text(channelName).font(.custom("HelveticaNeue-Bold", size: 16.0))
            }.padding(.top, 8)
            Divider()
        }
    }
}

struct InvitesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        InvitesListItemView(iconUrl: "https://content.testing.gramble.com/games/providers/twitter.png", channelName: "Demo Channel")
    }
}
