import SwiftUI

struct AlbumView: View {
  let album: Album
  
  var body: some View {
    VStack {
      AlbumCover(url: album.cover)
      AlbumTechDetailsView(album: album)
        .offset(y: -2)
      
      Text(album.displayTitle)
      Text(album.artist ?? "")
        .foregroundColor(.accentColor)
      Spacer()
    }
    .padding(ALBUM_PADDING)
    .frame(width: ALBUM_WIDTH, height: ALBUM_HEIGHT)
//    .border(self.getBorder(), width: 1)
  }
  
  func getBorder() -> Color {
    switch album.status {
      case .new:
        return Color.green
      case .parsingFiles:
        return Color.pink
      case .parsingFilesComplete:
        return Color.purple
      case .requestingMetadata:
        return Color.yellow
      case .requestingMetadataComplete:
        return Color.orange
      case .transcoding:
        return Color.gray
      case .transcodingComplete:
        return Color.blue
      case .parsingFilesFailed,
           .requestingMetadataFailed,
           .transcodingFailed:
        return Color.red
    }
  }
}


struct Album_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView(album: getTestAlbum())
  }
}
