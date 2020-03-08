import SwiftUIFlux

func stateReducer(state: AppState, action: Action) -> AppState {
  var state = state
  state.ui = uiReducer(state: state.ui, action: action)
  state.albums = albumsReducer(state: state.albums, action: action)
  return state
}
