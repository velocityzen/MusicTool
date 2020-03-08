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
    HStack(spacing: 20) {
      VStack {
        AlbumCover(url: album.cover)
        Spacer()
      }
      VStack(alignment: .leading) {
        Text(album.displayTitle)
          .font(.title)
          
        Text(album.artist ?? "")
          .font(.title)
          .foregroundColor(.accentColor)
        
        Spacer()
      }
      Spacer()
    }
    .padding(ALBUM_PADDING)
  }
}

struct AlbumDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailsView(album: getTestAlbum())
  }
}
