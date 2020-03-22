import Combine
import Dispatch
import Foundation

let readyForFileParsingAlbums = PassthroughSubject<Album, Never>()
let readyForMetadataAlbums = PassthroughSubject<Album, Never>()
let readyForTranscodeAlbums = PassthroughSubject<Album, Never>()

func initWorkersSubjects(_ queue: DispatchQueue) -> AnyCancellable {
  return store.subscribe()
    .subscribe(on: queue)
    .debounce(for: 1, scheduler: queue)
    .sink { state in
      
      // TODO: check the speed and maybe do batch send/updates
      for album in state.albums.items {
        switch album.status {
          case .new:
            print("is main thread: \(Thread.isMainThread)")
            setAlbumStatusAction(id: album.id, status: .parsingFiles)
            readyForFileParsingAlbums.send(album)
            break
          
          case .parsingFilesComplete:
            // if auto metadata request
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
    }
}
