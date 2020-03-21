import Foundation

struct AlbumDirectory {
  var url: URL
  var musicFiles: [URL]
  var imageFiles: [URL]
  var cueFiles: [URL]
}

func getAlbums(from url: URL, callback: (Album) -> Void) {
  guard let albumDirectories = getFilesInGroups(url) else {
    return
  }
  
  if (albumDirectories.isEmpty) {
    return
  }
  
  albumDirectories.forEach{ albumDirectory in
    if albumDirectory.musicFiles.isEmpty {
      return
    }
    
    let album = Album(from: albumDirectory)    
    callback(album)
  }
}

func getFilesInGroups(_ url: URL) -> [AlbumDirectory]? {
  let fileMngr = FileManager.default
  var result: [AlbumDirectory] = [AlbumDirectory(
    url: url,
    musicFiles: [],
    imageFiles: [],
    cueFiles: []
  )]
  
  do {
    let directoryContents = try fileMngr.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        
    for url in directoryContents {
      if (url.hasDirectoryPath) {
        guard let albumDirectories = getFilesInGroups(url) else {
          continue
        }
        
        if (albumDirectories.isEmpty) {
          continue
        }
        
        result.append(contentsOf: albumDirectories)
        continue
      }
      
      if (MUSIC_FILE_TYPES.contains(url.pathExtension)) {
        result[0].musicFiles.append(url)
      }
      
      if (IMAGE_FILE_TYPES.contains(url.pathExtension)) {
        result[0].imageFiles.append(url)
      }
      
      if (CUE_FILE_TYPES.contains(url.pathExtension)) {
        result[0].cueFiles.append(url)
      }
    }
  
    return result
  } catch {
    print(error)
    return nil
  }
}
