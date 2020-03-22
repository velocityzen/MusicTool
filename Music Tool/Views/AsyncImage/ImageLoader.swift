import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
  private static let imageProcessingQueue = DispatchQueue(label: "image.processing")

  @Published var image: NSImage?
  private let url: URL?
  private var cache: ImageCache?
  private let maxSize: NSSize?
  
  private var cancellable: AnyCancellable?
  private(set) var isLoading = false
  
  init(url: URL?, maxSize: NSSize? = nil, cache: ImageCache? = nil) {
    self.url = url
    self.maxSize = maxSize
    self.cache = cache
  }
  
  func load() {
    guard let url = self.url else {
      return
    }
    
    guard !isLoading else {
      return
    }
    
    if let image = cache?[url] {
      self.image = image
      return
    }
    
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: Self.imageProcessingQueue)
      .map { NSImage(data: $0.data, maxSize: self.maxSize) }
      .replaceError(with: nil)
      .handleEvents(
        receiveSubscription: { [unowned self] _ in self.onStart() },
        receiveOutput: { [unowned self] in self.cache($0) },
        receiveCompletion: { [unowned self] _ in self.onFinish() },
        receiveCancel: { [unowned self] in self.onFinish() }
      )
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }
  
  func cancel() {
    cancellable?.cancel()
  }
  
  private func onStart() {
    isLoading = true
  }
  
  private func onFinish() {
    isLoading = false
  }
  
  private func cache(_ image: NSImage?) {
    guard let url = self.url else {
      return
    }
  
    image.map { cache?[url] = $0 }
  }
}
