import SwiftUI
import KingfisherSwiftUI

struct AlbumCover: View {
  let url: URL?
  
  var body: some View {
    KFImage(url)
      .placeholder { AlbumDefaultCover() }
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: ALBUM_COVER_SIZE, height: ALBUM_COVER_SIZE)
      .cornerRadius(8)
      .shadow(radius: 5)
  }
}
