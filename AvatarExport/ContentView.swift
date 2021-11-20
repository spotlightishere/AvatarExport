//
//  ContentView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import SwiftUI

struct ContentView: View {
    let bleh = [
        AVTMemoji.neutral()
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bleh, id: \.self) { name in
                    NavigationLink(destination: AvatarView(memoji: name)) {
//                        Image(nsImage: AVTAnimoji.thumbnail(forAnimojiNamed: name, options: nil))
//                            .resizable()
//                            .scaledToFit()
                        Text("Neutral Animoji")
                            .font(.caption)
                    }
                }
                
                ForEach(AVTAnimoji.animojiNames(), id: \.self) { name in
                    NavigationLink(destination: AvatarView(animoji: name)) {
                        Image(nsImage: AVTAnimoji.thumbnail(forAnimojiNamed: name, options: nil))
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }.onAppear(perform: {
//            let heck = AVTPAvatarRecordDataSource.defaultUIDataSource(withDomainIdentifier: Bundle.main.bundleIdentifier!)
//            let z = heck.record(at: 1)
//            print(z)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
