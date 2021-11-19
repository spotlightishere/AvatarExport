//
//  ContentView.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(AVTAnimoji.animojiNames(), id: \.self) { name in
                    NavigationLink(destination: AvatarView(name: name)) {
                        Image(nsImage: AVTAnimoji.thumbnail(forAnimojiNamed: name, options: nil))
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
