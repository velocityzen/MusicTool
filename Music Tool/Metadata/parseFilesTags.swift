import Foundation
import Dispatch

func parseFilesTags(_ album: Album, done: @escaping (_ errors: [Error]?) -> Void) {
  print("parsing \(album.id) \(Thread.isMainThread)")
  sleep(UInt32.random(in: 1...5))

  done(nil)
}

