import SwiftUI
import SwiftUIFlux

struct Main: ConnectedView {
  struct Props {
    let hasAlbums: Bool
    let openAlbum: Album?
  }

  func body(props: Props) -> some View {
    Group {
      if props.openAlbum != nil {
        AlbumDetailsView(album: props.openAlbum!)
      } else if props.hasAlbums {
        AlbumsView()
      } else {
        DropView()
      }
    }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
  }
}

extension Main {
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    let openAlbumId = state.ui.openAlbumId
    
    print(state)
    
    return Props(
      hasAlbums: !state.albums.items.isEmpty,
      openAlbum: openAlbumId == nil ? nil : state.albums.items.get(openAlbumId!) 
    )
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
