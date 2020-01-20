//
//  DemoListView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct DemoView: View {

    var body: some View {
        NavigationView {
            VStack {
                //CurrentUserView()
                List {
                    NavigationLink(destination: InvitesView()) {
                        DemoListItemView(title: "Invites")
                    }
                    NavigationLink(destination: ActivitiesView()) {
                        DemoListItemView(title: "Feeds")
                    }
                }
            }
            .navigationBarTitle("Demo", displayMode: .inline)
        }
    }
}

struct DemoListView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
