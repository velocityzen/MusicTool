import SwiftUI

private let coverSize = NSSize(width: ALBUM_COVER_SIZE, height: ALBUM_COVER_SIZE)

struct AlbumCover: View {
  let url: URL?
  
  var body: some View {
    AsyncImage(url, placeholder: AlbumDefaultCover(), maxSize: coverSize)
      .aspectRatio(contentMode: .fill)
      .frame(width: ALBUM_COVER_SIZE, height: ALBUM_COVER_SIZE)
      .cornerRadius(8)
      .shadow(radius: 5)
  }
}
