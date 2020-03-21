import Cocoa
import Foundation

protocol ImageCache {
  subscript(_ url: URL) -> NSImage? { get set }
}

struct GlobalImageCache: ImageCache {
  private let cache = NSCache<NSURL, NSImage>()
  
  subscript(_ key: URL) -> NSImage? {
    get { cache.object(forKey: key as NSURL) }
    set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
  }
}

var globalImageCache = GlobalImageCache()
