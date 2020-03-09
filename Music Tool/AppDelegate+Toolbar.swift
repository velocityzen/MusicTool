import Cocoa
import SwiftUI
import SwiftUIFlux

extension AppDelegate: NSToolbarDelegate {
  func initToolbar() {
    let toolbar = NSToolbar(identifier: "musictool.toolbar")
    toolbar.allowsUserCustomization = false
    toolbar.autosavesConfiguration = false
    toolbar.displayMode = .iconOnly
    toolbar.delegate = self
    window.toolbar = toolbar
  }
  
  func toggleToolbar(_ isVisible: Bool) {
    window.toolbar?.isVisible = !isVisible
  }
  
  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
    
    if itemIdentifier == .connectedView {
      return getConnectedViewToolbarItem()
    }
    
    return nil
  }
  
  func getConnectedViewToolbarItem() -> NSToolbarItem {
    let toolbarItem = ConnectedViewToolbarItem(itemIdentifier: .connectedView)
    return toolbarItem
  }
    
  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [.connectedView]
  }
  
  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [.connectedView]
  }
}

private extension NSToolbarItem.Identifier {
  static let connectedView: NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "ConnectedView")
}
