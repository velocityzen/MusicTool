import Foundation
import SwiftUIFlux

struct AppState: FluxState {
  var albums: AlbumsState
}

struct AlbumsState: FluxState, Codable {
  var items: OrderedSet<Album> = OrderedSet()
}
