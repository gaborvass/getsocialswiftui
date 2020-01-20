//
//  InvitesViewModel.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import Foundation
import GetSocial

class InvitesViewModel: ObservableObject {

    @Published
    var availableInviteChannels: [GetSocialInviteChannel] = []

    @Published
    var showActivityIndicator: Bool = false

    required init() {
        GetSocial.initialize()
        GetSocial.execute {
            self.availableInviteChannels = GetSocial.inviteChannels()
        }
    }

    func onInviteChannelSelected(channelId: String) {
        self.showActivityIndicator = true
        GetSocial.sendInvite(withChannelId: channelId, success: {
            self.showActivityIndicator = false
            print("sent")
        }, cancel: {
            self.showActivityIndicator = false
            print("canceled")
        }) { error in
            self.showActivityIndicator = false
            print("error: \(error)")
        }
    }

}

extension GetSocialInviteChannel: Identifiable {

}


