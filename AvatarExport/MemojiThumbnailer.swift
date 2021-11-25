//
//  MemojiThumbnailer.swift
//  AvatarExport
//
//  Created by Spotlight Deveaux on 2021-11-24.
//

import Foundation

class MemojiThumbnailer: NSObject {
    let dataSource = AVTPAvatarRecordDataSource.defaultUIDataSource(withDomainIdentifier: Bundle.main.bundleIdentifier!)
    let options = AVTStickerGeneratorOptions.default()

    var rendered: NSImage?
    var avatar: AVTAvatar?

    func allPuppets() -> [AVTAvatarRecord] {
        var records: [AVTAvatarRecord] = []

        for recordIndex in 0 ..< dataSource.numberOfRecords() {
            records.append(dataSource.record(at: recordIndex))
        }
        return records
    }

    func thumbnailPuppet(record: AVTAvatarRecord) -> (NSImage, AVTAvatar) {
        // TODO: What does 1 signify?
        let render = AVTAvatarRecordRendering.avatar(for: record, usageIntent: 1)

        let generator = AVTStickerGenerator(avatar: render)
        generator.setAsync(false)

        let configurations = AVTStickerConfiguration.stickerConfigurationsForMemoji(inStickerPack: kAVTStickerPackPoses)
        let first = configurations.firstObject! as! AVTStickerConfiguration

        let image = generator.stickerImage(with: first, options: options, completionHandler: { rendered, avatar in
            self.rendered = rendered
            self.avatar = avatar
        })
        return (rendered!, avatar!)
    }
}
