import Foundation
import SwiftUIFlux

struct AlbumsActions {
  struct Parse: AsyncAction {
    let url: URL

    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
      DispatchQueue.global(qos: .userInitiated).async {
        getAlbums(from: self.url) { album in
          dispatch(Add(album: album))
        }
      }
    }
  }
  
  struct Add: Action {
    let album: Album
  }
  
  struct Remove: Action {
    let id: UUID
  }
  
  struct RemoveAll: Action {
    let ids: [UUID]
  }
  
  struct SetStatus: Action {
    let id: UUID
    let status: AlbumStatus
  }
  
  struct SetStatusAll: Action {
    let ids: [UUID]
    let status: AlbumStatus
  }
  
  struct SetCover: Action {
    let id: UUID
    let cover: URL
  }
}
