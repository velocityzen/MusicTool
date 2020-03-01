import SwiftUI
import SwiftUIFlux

struct Albums: ConnectedView {
  struct Props {
    let albums: OrderedSet<Album>
  }
  
  func body(props: Props) -> some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        Grid(
          geometry: geometry,
          itemsCount: props.albums.count,
          itemWidth: ALBUM_WIDTH
        ) { index in
          AlbumView(album: props.albums[index])
            .onTapGesture {
              print("Tapped")
          }
        }
      }
    }
  }
  
}

extension Albums {
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    return Props(albums: state.albums.items)
  }
}

extension Albums {
  func removeAlbum(_ id: UUID) {
    store.dispatch(action: AlbumsActions.Remove(id: id))
  }
  
  func removeAlbums(_ ids: [UUID]) {
    store.dispatch(action: AlbumsActions.RemoveAll(ids: ids))
  }
}
