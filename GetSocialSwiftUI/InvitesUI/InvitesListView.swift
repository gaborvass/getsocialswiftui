//
//  InvitesListView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI

struct InvitesListView: View {

    @ObservedObject
    var invitesViewModel: InvitesViewModel = InvitesViewModel()

    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        ZStack {
            List {
                ForEach(self.invitesViewModel.availableInviteChannels, id: \.channelId) { inviteChannel in
                    InvitesListItemView(iconUrl: inviteChannel.iconUrl, channelName: inviteChannel.name)
                        .onTapGesture {
                            self.invitesViewModel.onInviteChannelSelected(channelId: inviteChannel.channelId)
                    }.listRowInsets(EdgeInsets())
                }
            }
            if self.invitesViewModel.showActivityIndicator {
                ActivityIndicatorView()
            }
        }
    }
}

struct InvitesListView_Previews: PreviewProvider {
    static var previews: some View {
        InvitesListView()
    }
}
