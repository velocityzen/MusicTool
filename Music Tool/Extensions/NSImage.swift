import Cocoa

extension NSImage {
  convenience init?(data: Data, maxSize: NSSize? = nil) {
    guard maxSize != nil else {
      self.init(data: data)
      return
    }
    
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
      return nil
    }
        
    let screenScale = NSScreen.main?.backingScaleFactor ?? 1
    let maxDimensionInPixels = min(maxSize!.width, maxSize!.height)
    let downsampleOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: false,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels * screenScale
    ] as CFDictionary
    
    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
      return nil
    }
    
    self.init(cgImage: downsampledImage, size: maxSize!)
  }
}
