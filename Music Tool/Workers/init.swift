import Combine
import Dispatch

let readyForFileParsingAlbums = PassthroughSubject<Album, Never>()
let readyForMetadataAlbums = PassthroughSubject<Album, Never>()
let readyForTranscodeAlbums = PassthroughSubject<Album, Never>()

func initWorkersSubjects() -> AnyCancellable {
  let queue = DispatchQueue.global(qos: .userInitiated)
  return store.subscribe()
    .receive(on: queue)
    .debounce(for: 1, scheduler: queue)
    .sink { state in
      let albums = state.albums.items
//      var setStatusAllParsing: [Album.ID] = []
      
      for album in albums {
        switch album.status {
          case .new:
            setAlbumStatusAction(id: album.id, status: .parsingFiles)
            readyForFileParsingAlbums.send(album)
            break
          
          case .parsingFilesComplete:
            // if auto metdata request
            // setAlbumStatusAction(id: album.id, status: .requestingMetadata)
            // readyForMetadataAlbums.send(album)
            break
          
          case .requestingMetadataComplete:
            // if auto transcode
            // setAlbumStatusAction(id: album.id, status: .transcoding)
            // readyForTranscodeAlbums.send(album)
            break
          
          default:
            break
        }
      }
      
//      if (setStatusAllParsing.count > 0) {
//        store.dispatch(action: AlbumsActions.SetStatusAll(
//          ids: setStatusAllParsing,
//          status: .parsingFiles
//        ))
//      }
      
    }
}
