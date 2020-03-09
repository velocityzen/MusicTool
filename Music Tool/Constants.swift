import Foundation

let UUID_NAMESPACE = UUID()

let MUSIC_FILE_TYPES = [ "flac", "ape", "wv", "m4a", "mp3" ]
let CUE_FILE_TYPES = [ "cue" ]
let IMAGE_FILE_TYPES = [ "jpg", "jpeg", "png" ]

let COVER_PATTERNS = [ "cover", "front", "folder" ]

let ALBUM_WIDTH: CGFloat = 220.0
let ALBUM_HEIGHT: CGFloat = 320.0
let ALBUM_PADDING: CGFloat = 10.0

let ALBUM_COVER_SIZE: CGFloat = ALBUM_WIDTH - ALBUM_PADDING * 2

func getAlbumsNumber(in width: CGFloat) -> Int {
  return max(
    1,
    Int(
      (width - ALBUM_PADDING  - ALBUM_PADDING) / ALBUM_WIDTH
    )
  )
}
