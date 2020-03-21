import SwiftUI
import SwiftUIFlux

struct ToolbarView: ConnectedView {
  struct Props {
    let isOpenAlbum: Bool
    let isMetadataQueueEmpty: Bool
    let isTranscodeQueueEmpty: Bool
  }
  
  func body(props: Props) -> some View {
    HStack {
      if (props.isOpenAlbum) {
        Button(action: {
          self.close()
        }) {
          Text("Back")
        }
      }
      
      Button(action: {
        self.addToMetadataRequestQueue()
      }) {
        Text("Get Metadata")
      }

      Spacer()

      Button(action: {
        self.addToTranscodeQueue()
      }) {
        Text("Transcode")
      }
    }
    .frame(height: 40)
  }
  
}

extension ToolbarView {
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    return Props(
      isOpenAlbum: state.ui.openAlbumId != nil,
      isMetadataQueueEmpty: state.ui.metadataQueue.isEmpty,
      isTranscodeQueueEmpty: state.ui.transcodeQueue.isEmpty
    )
  }
  
  func close() {
    store.dispatch(action: UIActions.Close())
  }
  
  func addToMetadataRequestQueue() {
    addItemsToMetadataRequestQueue()
  }
  
  func addToTranscodeQueue() {
    addItemsToTranscodeQueue()
  }
}

