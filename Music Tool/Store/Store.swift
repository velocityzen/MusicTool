import Foundation
import SwiftUIFlux
import Combine

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

extension Store {
  func subscribe() -> AnyPublisher<StoreState, Never> {
    return self.$state
      .share()
      .eraseToAnyPublisher()
  }
}

let store = Store<AppState>(
  reducer: stateReducer,
  state: AppState(
    ui: UIState(),
    albums: AlbumsState()
  )
)

