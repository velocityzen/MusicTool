//
//  AlbumTrackList.swift
//  Music Tool
//
//  Created by velocityzen on 3/8/20.
//  Copyright © 2020 velocityzen. All rights reserved.
//

import SwiftUI

struct AlbumTrackList: View {
  let album: Album
  
  var body: some View {
    ForEach(0..<album.musicFiles.count) { index in
      HStack {
        Text("\(index + 1)")
          .frame(width: 20, alignment: .leading)
          .foregroundColor(.secondary)
        Text("\(self.album.musicFiles[index].lastPathComponent)")
      }
      .padding(.top, 10)
      .padding(.bottom, 10)
    }
  }
}

struct AlbumTrackList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumTrackList(album: getTestAlbum())
  }
}
