import Foundation

struct Album: Codable, Identifiable {
  let id: UUID
  let url: URL
  let musicFiles: [URL]
  let imageFiles: [URL]
  let cueFiles: [URL]
  
  var title: String? = nil
  var artist: String? = nil
  var cover: URL? = nil
  
  var displayTitle: String {
    guard let title = self.title else {
      return self.url.lastPathComponent
    }
    
    return title
  }
}

extension Album {
  init(from albumDirectory: AlbumDirectory) {
    id = UUID(namespace: UUID_NAMESPACE, name: albumDirectory.url.absoluteString)!
    url = albumDirectory.url
    musicFiles = albumDirectory.musicFiles
    imageFiles = albumDirectory.imageFiles
    cueFiles = albumDirectory.cueFiles
    cover = getCoverURL(self)
  }
}

extension Album: CustomDebugStringConvertible {
  var debugDescription: String {
    return "\(displayTitle) | " +
      "music files: \(musicFiles.count) / " +
      "image files \(imageFiles.count) / " +
      "cue files \(cueFiles.count)"
  }
}

