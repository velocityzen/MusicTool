import SwiftUI
import KingfisherSwiftUI

struct AlbumView: View {
  let album: Album
  
  var body: some View {
    VStack {
      KFImage(album.cover)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: ALBUM_COVER_SIZE, height: ALBUM_COVER_SIZE)
        .cornerRadius(8)
        .shadow(radius: 5)
      
      AlbumTechDetailsView(album: album)
        .offset(y: -2)
      
      Text(album.displayTitle)
      Text(album.artist ?? "")
        .foregroundColor(.accentColor)
      Spacer()
    }
    .padding(10)
    .frame(width: ALBUM_WIDTH, height: ALBUM_HEIGHT)
    .fixedSize()
    
  }
}

struct Album_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView(album: Album(
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
