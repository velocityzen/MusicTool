import SwiftUIFlux

func albumsReducer(state: AlbumsState, action: Action) -> AlbumsState {
  var state = state
  switch action {
    case let action as AlbumsActions.Add:
      state.items.append(action.album)
    
    case let action as AlbumsActions.Remove:
      state.items.remove(action.id)
    
    case let action as AlbumsActions.RemoveAll:
      state.items.removeAll(action.ids)
    
    case let action as AlbumsActions.SetStatus:
      state.items.updateElement(id: action.id, keyPath: \.status, value: action.status)
    
    case let action as AlbumsActions.SetStatusAll:
      state.items.updateElements(ids: action.ids, keyPath: \.status, value: action.status)
    
    default:
      break
  }
  
  return state
}
