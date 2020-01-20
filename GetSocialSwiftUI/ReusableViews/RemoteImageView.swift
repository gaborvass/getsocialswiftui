//
//  RemoteImageView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI
import Combine

private class RemoteUIImage: ObservableObject {

    @Published
    var uiImage: UIImage

    @ObservedObject
    private var remoteDataHandler: RemoteDataHandler = RemoteDataHandler.empty()

    init(placeholder: String, url: String?) {
        uiImage = UIImage.init(named: placeholder)!
        guard let url = url else {
            return
        }
        remoteDataHandler = RemoteDataHandler(remoteUrl: url)
        let _ = remoteDataHandler.remoteData.subscribe(on: RunLoop.main).sink(receiveValue: { remoteData in
            self.uiImage = UIImage.init(data: remoteData)!
        })
        remoteDataHandler.download()
    }
}

struct RemoteImageView: View {

    @ObservedObject
    private var uiImage: RemoteUIImage

    init(url: String?, placeholder: String) {
        uiImage = RemoteUIImage(placeholder: placeholder, url: url)
    }

    var body: Image {
        Image(uiImage: uiImage.uiImage).resizable()
    }

}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: "https://content.testing.gramble.com/games/providers/twitter.png", placeholder: "facebook").body
    }
}
