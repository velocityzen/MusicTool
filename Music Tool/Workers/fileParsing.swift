import Combine
import Dispatch
import Foundation

private struct Result {
  let id: Album.ID
  let errors: [Error]?
}

func initFileParsingSubscription(_ queue: DispatchQueue) -> AnyCancellable {
  return readyForFileParsingAlbums
    .subscribe(on: queue)
    .receive(on: DispatchQueue.global())
    .flatMap { album in
      Future { promise in
        parseFilesTags(album) { errors in
          promise(.success(Result(
            id: album.id,
            errors: errors
          )))
        }
      }
    }
    .receive(on: DispatchQueue.main)
    .sink { result in
      store.dispatch(action: AlbumsActions.SetStatus(
        id: result.id,
        status: result.errors == nil ? .parsingFilesComplete : .parsingFilesFailed
      ))
    }
}

