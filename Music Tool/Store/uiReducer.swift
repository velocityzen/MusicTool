import SwiftUIFlux

func uiReducer(state: UIState, action: Action) -> UIState {
  var state = state
  switch action {
    case let action as UIActions.Open:
      state.openAlbumId = action.id
    
    case let action as UIActions.Close:
      state.openAlbumId = nil
    
    case let action as UIActions.AddToGetMetadataQueue:
      state.metadataQueue = state.metadataQueue.union(action.ids)
    
    case let action as UIActions.AddToTranscodeQueue:
      state.transcodeQueue = state.transcodeQueue.union(action.ids)
    
    default:
      break
  }
  
  return state
}
