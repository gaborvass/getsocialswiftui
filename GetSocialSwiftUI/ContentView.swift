//
//  ContentView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DemoView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InvitesListItemView(iconUrl: "https://content.testing.gramble.com/games/providers/twitter.png", channelName: "Demo Channel")

    }
}
