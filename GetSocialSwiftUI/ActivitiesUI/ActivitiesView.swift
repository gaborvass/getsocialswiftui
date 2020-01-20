//
//  ActivitiesView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 20/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI

enum NavigationEvent {
    case showDetail
    case showImage
    case showVideo
    case showComments
}

struct ActivitiesView: View {

    @State
    var isShowDetailActive: Bool = false

    var body: some View {
        ActivitiesListView().navigationBarTitle("Feeds", displayMode: .inline)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
