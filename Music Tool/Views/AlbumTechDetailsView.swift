import SwiftUI
import KingfisherSwiftUI

struct AlbumTechDetailsView: View {
  let album: Album
  
  var body: some View {
    HStack(alignment: .center) {
      HStack {
        Text(self.from) + Text(" → ") + Text(self.to)
      }
      .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
      .background(Color.accentColor)
      .cornerRadius(12)
    }
    .font(.system(.caption, design: .monospaced))
    .frame(maxWidth: .infinity)
    .frame(height: 40)
  }
  
  var from: String {
    let exts = Set<String>(album.musicFiles.map { $0.pathExtension })
    return exts.joined(separator: ", ")
  }
  
  var to: String {
    return "mp4"
  }
}

struct AlbumTechDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumTechDetailsView(album: Album(
      id: UUID(),
      url: URL(string: "file://some")!,
      musicFiles: [URL(string: "file://some.flac")!],
      imageFiles: [URL(string: "file://some.jpg")!],
      cueFiles: [URL(string: "file://some.cue")!],
      
      title: "Title",
      artist: "Artist",
      cover: URL(string: "file:///Users/velocityzen/Downloads/new%20music/1977%20-%20Screamin%20Jay%20Hawkins%20-%20I%20Put%20A%20Spell%20On%20You/cover01.jpg")!
    ))
  }
}
