import Foundation

func getCoverURL(_ album: Album) -> URL? {
  guard let cover = album.cover else {
    return selectCoverUrl(album.imageFiles)
  }
  
  return cover
}

func selectCoverUrl(_ urls: [URL]) -> URL? {
  if urls.isEmpty {
    return nil
  }
  
  let sortedImages = urls.sorted(by: sortCovers)
  return sortedImages.first
}

func sortCovers(a: URL, b: URL) -> Bool {
  let nameA = a.lastPathComponent.lowercased()
  let indexA = COVER_PATTERNS.firstIndex(where: { nameA.contains($0)}) ?? COVER_PATTERNS.count
  
  let nameB = b.lastPathComponent.lowercased()
  let indexB = COVER_PATTERNS.firstIndex(where: { nameB.contains($0)}) ?? COVER_PATTERNS.count
  
  return indexA < indexB
}
