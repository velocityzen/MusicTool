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
        HStack(spacing: 0) {
          
          VStack {
            AlbumCover(url: self.album.cover)
            Spacer()
          }
          .padding(ALBUM_PADDING)
          
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
          .padding(ALBUM_PADDING)
          
          Spacer()
        }
        .frame(maxWidth: self.getMaxWidth(geometry))
        .padding(EdgeInsets(top: ALBUM_PADDING, leading: ALBUM_PADDING, bottom: 0, trailing: ALBUM_PADDING))
      }
    }
  }
  
  func getMaxWidth(_ geometry: GeometryProxy) -> CGFloat {
    let albumsNumber = getAlbumsNumber(in: geometry.size.width)
    let maxWidth = ALBUM_WIDTH * CGFloat(albumsNumber)
    
    return maxWidth
  }
}

struct AlbumDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailsView(album: getTestAlbum())
  }
}
