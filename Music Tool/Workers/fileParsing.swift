import Combine
import Dispatch

private struct Result {
  let id: Album.ID
  let errors: [Error]?
}

func initFileParsingSubscription() -> AnyCancellable {
  return readyForFileParsingAlbums
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
  .sink { result in
    store.dispatch(action: AlbumsActions.SetStatus(
      id: result.id,
      status: result.errors == nil ? .parsingFilesComplete : .parsingFilesFailed
    ))
  }
}

