//
//  MemojiThumbnailer.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-24.
//

import Foundation

class MemojiThumbnailer: NSObject {
    static public let shared = MemojiThumbnailer()
    
    let dataSource = AVTPAvatarRecordDataSource.defaultUIDataSource(withDomainIdentifier: Bundle.main.bundleIdentifier!)
    let options = AVTStickerGeneratorOptions.default()

    var rendered: NSImage?

    func allPuppets() -> [AVTAvatarRecord] {
        var records: [AVTAvatarRecord] = []

        for recordIndex in 0 ..< dataSource.numberOfRecords() {
            records.append(dataSource.record(at: recordIndex))
        }
        return records
    }

    func renderPuppet(record: AVTAvatarRecord) -> AVTAvatar {
        // TODO: What does 1 signify?
        AVTAvatarRecordRendering.avatar(for: record, usageIntent: 1)
    }

    func thumbnailPuppet(record: AVTAvatarRecord) -> NSImage {
        let render = renderPuppet(record: record)
        let generator = AVTStickerGenerator(avatar: render)
        // Ensures completionHandler does not immediately return
        generator.setAsync(false)

        let configurations = AVTStickerConfiguration.stickerConfigurationsForMemoji(inStickerPack: kAVTStickerPackPoses)
        let first = configurations.firstObject! as! AVTStickerConfiguration

        generator.stickerImage(with: first, options: options, completionHandler: { rendered, _ in
            self.rendered = rendered
        })
        return rendered!
    }
}
