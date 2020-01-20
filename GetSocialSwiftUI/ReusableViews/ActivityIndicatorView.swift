//
//  ActivityIndicatorView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 06/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: View {

    @State
    private var rotationDegree: Double = 0

    private var image: Image = Image.init("loading-indicator.bg-image")

    var animation = Animation.linear(duration: 0.8).repeatForever(autoreverses: false)

    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            image.resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .rotationEffect(Angle(degrees: rotationDegree))
                .animation(animation)
                .onAppear {
                    withAnimation(self.animation) {
                        self.rotationDegree = 360
                    }
                }
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
