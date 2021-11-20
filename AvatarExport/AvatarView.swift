//
//  AvatarView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import SceneKit
import SwiftUI

struct AvatarView: NSViewRepresentable {
    let avatar: AVTAvatar
    let name: String

    init(animoji: String) {
        name = animoji
        avatar = AVTAnimoji(named: animoji)
    }
    
    init(memoji: AVTMemoji) {
        name = "Neutral Animoji"
        avatar = memoji
    }

    func makeNSView(context _: Context) -> NSView {
        let avatarView = AVTView()
        avatarView.avatar = avatar

        let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let savePath = downloadsDirectory.appendingPathComponent("\(name).dae")

        avatarView.scene?.write(to: savePath, options: nil, delegate: nil, progressHandler: nil)

        return avatarView
    }

    func updateNSView(_: NSView, context _: Context) {}
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(animoji: "fox")
    }
}
