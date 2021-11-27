//
//  AvatarIO.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-26.
//

import Foundation

struct AvatarRecord: Codable {
    var name: String
    var record: Data
}

struct AvatarRecords: Codable {
    var avatars: [AvatarRecord] = []
}

// It would be nice to permit importing at some point in time.
// TODO: import

func exporter(_ thumbnailer: MemojiThumbnailer) {
    var endData = AvatarRecords()

    do {
        var current = 1
        for record in thumbnailer.allPuppets() {
            // We only want Memoji ("AVTAvatarRecord"), not Animoji ("AVTAvatarPuppetRecord", a subclass of the former).
            if record.className == "AVTAvatarPuppetRecord" {
                continue
            }

            let data = try NSKeyedArchiver.archivedData(withRootObject: record, requiringSecureCoding: true)
            endData.avatars.append(AvatarRecord(name: "Unknown Memoji \(current)", record: data))

            current += 1
        }

        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let plist = try encoder.encode(endData)

        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(String(data: plist, encoding: .utf8)!, forType: .string)
    } catch let e {
        print(e)
    }
}
