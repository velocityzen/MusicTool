import Foundation
import Dispatch

func parseFilesTags(_ album: Album, done: @escaping (_ errors: [Error]?) -> Void) {
  DispatchQueue.global().async {
    print("parsing \(album.id)")
    sleep(UInt32.random(in: 1...3))
    
    DispatchQueue.main.async {
      done(nil)
    }
  }
}

