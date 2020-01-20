//
//  InvitesView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI

struct InvitesView: View {

    var body: some View {
        InvitesListView().navigationBarTitle("Invites", displayMode: .inline)
    }
}

struct InvitesView_Previews: PreviewProvider {
    static var previews: some View {
        InvitesView()
    }
}
