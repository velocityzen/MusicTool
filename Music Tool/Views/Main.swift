import SwiftUI
import SwiftUIFlux

struct Main: ConnectedView {
  struct Props {
    let hasAlbums: Bool
  }

  func body(props: Props) -> some View {
    Group {
      if props.hasAlbums {
        Albums()
      } else {
        Drop()
      }
    }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
  }
}

extension Main {
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    return Props(hasAlbums: !state.albums.items.isEmpty)
  }
}

extension Main: DropDelegate {
  func performDrop(info: DropInfo) -> Bool {
    let itemProviders = info.itemProviders(for: [(kUTTypeFileURL as String)])
    
    if (itemProviders.isEmpty) {
      return false
    }
    
    itemProviders.forEach { itemProvider in
      itemProvider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
        guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
        
        DispatchQueue.main.async {
          self.parseUrl(url: url)
        }
      }
    }
    
    return true
  }
  
  func parseUrl(url: URL) {
    store.dispatch(action: AlbumsActions.Parse(url: url))
  }
}
