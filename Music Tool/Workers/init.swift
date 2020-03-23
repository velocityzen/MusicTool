import Combine
import Dispatch
import Foundation

let readyForFileParsingAlbums = PassthroughSubject<Album, Never>()
let readyForMetadataAlbums = PassthroughSubject<Album, Never>()
let readyForTranscodeAlbums = PassthroughSubject<Album, Never>()

func initWorkersSubjects() -> AnyCancellable {
  return store.subscribe()
    .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInitiated))
    .sink { state in
      print("Init 2: isMain \(Thread.isMainThread)")
      // TODO: check the speed and maybe do batch send/updates
      for album in state.albums.items {
        switch album.status {
          case .new:
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
