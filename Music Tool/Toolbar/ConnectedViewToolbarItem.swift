import Cocoa
import SwiftUI
import SwiftUIFlux

class ConnectedViewToolbarItem: NSToolbarItem {
  override init(itemIdentifier: NSToolbarItem.Identifier) {
    super.init(itemIdentifier: itemIdentifier)
    
    self.label = "Toolbar"
    
    let toolbarView = StoreProvider(store: store) {
      ToolbarView()
    }
    
    let hostingView = NSHostingView(rootView: toolbarView)
    let viewSize = hostingView.fittingSize    
    self.view = hostingView
    self.minSize = viewSize
    self.maxSize = NSSize(width: CGFloat.infinity, height: viewSize.height)
  }
}
