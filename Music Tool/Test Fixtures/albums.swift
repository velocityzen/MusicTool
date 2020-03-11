//
//  albums.swift
//  Music Tool
//
//  Created by velocityzen on 3/3/20.
//  Copyright © 2020 velocityzen. All rights reserved.
//

import Foundation

func getTestAlbum() -> Album {
  return Album(
    id: UUID(),
    url: URL(string: "file://some")!,
    musicFiles: [URL(string: "file://some.flac")!],
    imageFiles: [URL(string: "file://some.jpg")!],
    cueFiles: [URL(string: "file://some.cue")!],
    
    title: "Title",
    artist: "Artist",
    cover: URL(string: "file:///Users/velocityzen/Downloads/new%20music/1977%20-%20Screamin%20Jay%20Hawkins%20-%20I%20Put%20A%20Spell%20On%20You/cover01.jpg")!,
    
    status: .new
  )
}
