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
        Button(action: close) {
          Text("Back")
        }
      }
      
      Button(action: addToMetadataRequestQueue) {
        Text("Get Metadata")
      }

      Spacer()

      Button(action: addToTranscodeQueue) {
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
    addItemsToMetadataRequestQueueAction()
  }
  
  func addToTranscodeQueue() {
    addItemsToTranscodeQueueAction()
  }
}

