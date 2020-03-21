import SwiftUI

struct AsyncImage<Placeholder: View>: View {
  @ObservedObject private var loader: ImageLoader
  private let placeholder: Placeholder?

  init(_ url: URL?, placeholder: Placeholder? = nil, cache: ImageCache? = globalImageCache) {
    self.loader = ImageLoader(url: url, cache: cache)
    self.placeholder = placeholder
  }
  
  var body: some View {
    image
      .onAppear(perform: loader.load)
      .onDisappear(perform: loader.cancel)
  }
  
  private var image: some View {
    Group {
      if loader.image != nil {
        Image(nsImage: loader.image!)
          .resizable()
      } else {
        placeholder
      }
    }
  }
  
  private var imageTransition: some View {
    AsyncImageTransition<Placeholder>(
      image: loader.image != nil ? Image(nsImage: loader.image!).resizable() : nil,
      placeholder: placeholder
    )
  }
}
