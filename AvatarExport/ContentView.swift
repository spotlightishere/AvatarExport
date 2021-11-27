//
//  ContentView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import MultipeerKit
import SwiftUI

struct ContentView: View {
    let thumbnailer = MemojiThumbnailer.shared
    @ObservedObject var datasource: MultipeerDataSource = {
        var config = MultipeerConfiguration.default
        config.serviceType = "avatar"
        config.security.encryptionPreference = .required
        
        let transceiver = MultipeerTransceiver(configuration: config)
        return MultipeerDataSource(transceiver: transceiver)
    }()

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
                        exporter()
                    }) {
                        Label("Share Memoji to Clipboard", systemImage: "square.and.arrow.up")
                    }
                    Button(action: {
                        let all = getMemoji()
                        datasource.transceiver.send(all, to: datasource.transceiver.availablePeers)
                    }) {
                        Label("Share Memoji to Local Devices", systemImage: "square.and.arrow.up")
                    }.disabled(datasource.availablePeers.isEmpty)
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }.onAppear(perform: {
            datasource.transceiver.resume()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
