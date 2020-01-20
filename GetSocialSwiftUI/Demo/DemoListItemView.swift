//
//  DemoListItemView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct DemoListItemView: View {

    var title: String

    var body: some View {
        Text(title)
    }
}

struct DemoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        DemoListItemView(title: "Demo")
    }
}
