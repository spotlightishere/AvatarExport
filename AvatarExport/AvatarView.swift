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

    init(animoji: String) {
        avatar = AVTAnimoji(named: animoji)
    }

    init(avatar: AVTAvatar) {
        self.avatar = avatar
    }

    func makeNSView(context _: Context) -> NSView {
        let avatarView = AVTView()
        avatarView.avatar = avatar

        let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let savePath = downloadsDirectory.appendingPathComponent("\(Date.now).scn")

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
