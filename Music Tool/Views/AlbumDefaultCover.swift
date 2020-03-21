//
//  AlbumDefaultCover.swift
//  Music Tool
//
//  Created by velocityzen on 3/8/20.
//  Copyright © 2020 velocityzen. All rights reserved.
//

import SwiftUI

struct AlbumDefaultCover: View {
  var body: some View {
    Image("defaultAlbumCover")
      .resizable()
  }
}

struct AlbumDefaultCover_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDefaultCover()
      .frame(width: ALBUM_COVER_SIZE, height: ALBUM_COVER_SIZE)
  }
}
