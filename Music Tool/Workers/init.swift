import Combine
import Dispatch
import Foundation

let readyForFileParsingAlbums = PassthroughSubject<Album, Never>()
let readyForMetadataAlbums = PassthroughSubject<Album, Never>()
let readyForTranscodeAlbums = PassthroughSubject<Album, Never>()

func initWorkersSubjects(_ queue: DispatchQueue) -> AnyCancellable {
  return store.subscribe()
    .debounce(for: 0.5, scheduler: RunLoop.main)
    .receive(on: queue)
    .sink { state in
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
