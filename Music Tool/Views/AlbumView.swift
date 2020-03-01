//
//  Album.swift
//  Music Tool
//
//  Created by velocityzen on 2/22/20.
//  Copyright © 2020 velocityzen. All rights reserved.
//

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
      
      Text(album.debugDescription)
    }
    .frame(width: ALBUM_WIDTH, height: ALBUM_HEIGHT)
  }
}

//struct Album_Previews: PreviewProvider {
//  static var previews: some View {
//    AlbumView(album: Album(
//      id: UUID(),
//      url: URL(string: "file://some")!,
//      musicFiles: [URL(string: "file://some.flac")!],
//      cueFiles: [URL(string: "file://some.cue")!],
//      imageFiles: [URL(string: "file://some.jpg")!],
//
//      title: "Title",
//      artist: "Artist",
//      cover: URL(string: "file:///usr/Users/velocityzen/Downloads/394562.jpg")!
//    ))
//  }
//}
