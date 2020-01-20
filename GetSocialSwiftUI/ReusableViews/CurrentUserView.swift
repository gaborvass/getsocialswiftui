//
//  CurrentUserView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI
import GetSocial

struct CurrentUserView: View {

    @ObservedObject
    private var viewModel = CurrentUserViewModel()

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            RemoteImageView(url: viewModel.avatarUrl, placeholder: "avatar.default-image").frame(width: 32, height: 32, alignment: .center)
                .cornerRadius(16).padding(8)
            Text(viewModel.displayName).padding(.top, 8)
            Spacer()
        }.background(Color.gray)

    }
}

class CurrentUserViewModel: ObservableObject {

    @Published
    var avatarUrl: String?

    @Published
    var displayName: String = ""


    init() {
        GetSocial.execute {
            self.avatarUrl = GetSocialUser.avatarUrl()
            self.displayName = GetSocialUser.displayName()!
        }
    }

}

struct CurrentUserView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserView()
    }
}
