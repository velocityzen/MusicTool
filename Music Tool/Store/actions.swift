func addItemsToMetadataRequestQueue() {
  let ids = store.state.ui.openAlbumId != nil ?
    [store.state.ui.openAlbumId!] :
    store.state.albums.items.map({$0.id})
  
  store.dispatch(action: UIActions.AddToGetMetadataQueue(ids: ids))
}

func addItemsToTranscodeQueue() {
  let ids = store.state.ui.openAlbumId != nil ?
    [store.state.ui.openAlbumId!] :
    store.state.albums.items.map({$0.id})
  
  store.dispatch(action: UIActions.AddToTranscodeQueue(ids: ids))
}
