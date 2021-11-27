//
//  AvatarIO.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-26.
//

import Foundation

struct AvatarRecord: Codable, Hashable {
    var name: String
    var record: AVTAvatarRecord

    enum CodingKeys: String, CodingKey {
        case name
        case record
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)

        let recordValue = try NSKeyedArchiver.archivedData(withRootObject: record, requiringSecureCoding: true)
        try container.encode(recordValue, forKey: .record)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)

        let recordValue = try container.decode(Data.self, forKey: .record)
        record = try NSKeyedUnarchiver.unarchivedObject(ofClass: AVTAvatarRecord.self, from: recordValue)!
    }
    
    init(name: String, record: AVTAvatarRecord) {
        self.name = name
        self.record = record
    }
}

class AvatarRecords: Codable {
    var avatars: [AvatarRecord] = []
}

// It would be nice to permit importing at some point in time.
// TODO: import

func getMemoji() -> AvatarRecords {
    let endData = AvatarRecords()
    
    var current = 1
    for record in MemojiThumbnailer.shared.allPuppets() {
        // We only want Memoji ("AVTAvatarRecord"), not Animoji ("AVTAvatarPuppetRecord", a subclass of the former).
        if record.className == "AVTAvatarPuppetRecord" {
            continue
        }

        endData.avatars.append(AvatarRecord(name: "Unknown Memoji \(current)", record: record))
        current += 1
    }
    
    return endData
}

func exporter() {
    do {
        let endData = getMemoji()
        
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
