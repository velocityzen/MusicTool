import Foundation
import SwiftUIFlux

struct UIActions {
  struct Open: Action {
    let id: UUID
  }
  
  struct Close: Action {
  }
  
  struct AddToGetMetadataQueue: Action {
    let ids: [UUID]
  }
  
  struct AddToTranscodeQueue: Action {
    let ids: [UUID]
  }
  
}
