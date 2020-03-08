import Foundation
import SwiftUIFlux

struct AppState: FluxState {
  var ui: UIState
  var albums: AlbumsState
}

struct UIState: FluxState, Codable {
  var openAlbumId: UUID? = nil
  var metadataQueue: Set<UUID> = Set()
  var transcodeQueue: Set<UUID> = Set()
}

struct AlbumsState: FluxState, Codable {
  var items: OrderedSet<Album> = OrderedSet()
}

let store = Store<AppState>(
  reducer: stateReducer,
  state: AppState(
    ui: UIState(),
    albums: AlbumsState()
  )
)
