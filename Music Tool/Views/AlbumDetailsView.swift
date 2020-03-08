//
//  AlbumDetailsView.swift
//  Music Tool
//
//  Created by velocityzen on 3/3/20.
//  Copyright © 2020 velocityzen. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct AlbumDetailsView: View {
  let album: Album
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        HStack {
          VStack {
            AlbumCover(url: self.album.cover)
            Spacer()
          }
          VStack(alignment: .leading) {
            Text(self.album.displayTitle)
              .font(.title)
              
            Text(self.album.artist ?? "")
              .font(.title)
              .foregroundColor(.accentColor)
            
            Divider()
            
            AlbumTrackList(album: self.album)
            
            Spacer()
          }
          Spacer()
        }
        .frame(maxWidth: self.getMaxWidth(geometry))
        .padding(EdgeInsets(top: ALBUM_PADDING, leading: ALBUM_PADDING, bottom: 0, trailing: ALBUM_PADDING))
      }
    }
  }
  
  func getMaxWidth(_ geometry: GeometryProxy) -> CGFloat {
    return ALBUM_WIDTH * CGFloat(max(
      1,
      Int(
        (geometry.size.width - ALBUM_PADDING  - ALBUM_PADDING) / ALBUM_WIDTH
      )
    ))
  }
}

struct AlbumDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailsView(album: getTestAlbum())
  }
}
