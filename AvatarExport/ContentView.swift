//
//  ContentView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import SwiftUI

struct ContentView: View {
    let thumbnailer = MemojiThumbnailer()

    var body: some View {
        NavigationView {
            List {
                ForEach(thumbnailer.allPuppets(), id: \.self) { record in
                    NavigationLink(destination: AvatarView(record: record)) {
                        Image(nsImage: thumbnailer.thumbnailPuppet(record: record))
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button(action: {
                        exporter(thumbnailer)
                    }) {
                        Label("Share Memoji to Property List", systemImage: "square.and.arrow.up")
                    }
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
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
