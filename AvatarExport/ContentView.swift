//
//  ContentView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import SwiftUI

struct ContentView: View {
    let thumbnailer = MemojiThumbnailer()

    let bleh = [
        AVTMemoji.neutral(),
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(thumbnailer.allPuppets(), id: \.self) { record in

                    let (rendered, avatar) = thumbnailer.thumbnailPuppet(record: record)
                    NavigationLink(destination: AvatarView(avatar: avatar)) {
                        Image(nsImage: rendered)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
