//
//  RemoteImageHandler.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 17/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import Foundation
import Combine

class RemoteDataHandler: ObservableObject {

    var remoteData: PassthroughSubject<Data, Never> = PassthroughSubject()
    private var remoteDataUrl: String

    public static func empty() -> RemoteDataHandler {
        return RemoteDataHandler(remoteUrl: "")
    }

    required init(remoteUrl: String) {
        remoteDataUrl = remoteUrl
    }

    func download() {
        guard let remoteUrl = URL(string: remoteDataUrl) else {
            return
        }
        DispatchQueue.global().async {
            guard let downloadedData = try? Data.init(contentsOf: remoteUrl) else {
                return
            }
            DispatchQueue.main.async {
                self.remoteData.send(downloadedData)
            }
        }
    }
}
