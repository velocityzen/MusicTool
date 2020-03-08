import Cocoa
import SwiftUI
import SwiftUIFlux

extension AppDelegate: NSToolbarDelegate {
  func initToolbar() {
    let toolbar = NSToolbar(identifier: "musictool.toolbar")
    toolbar.allowsUserCustomization = true
    toolbar.autosavesConfiguration = true
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
    
    if itemIdentifier == .getMetadata {
      return getGetMetadataToolbarItem()
    }
    
    if itemIdentifier == .transcode {
      return getTranscodeToolbarItem()
    }
    
    return nil
  }
  
  func getGetMetadataToolbarItem() -> NSToolbarItem {
    let toolbarItem = NSToolbarItem(itemIdentifier: .getMetadata)
    
    toolbarItem.label = NSLocalizedString("Get Metadata", comment: "")
    toolbarItem.paletteLabel = NSLocalizedString("Get Metadata", comment: "")
    toolbarItem.toolTip = NSLocalizedString("Get metadata", comment: "")
    toolbarItem.view = NSButton(
      title: toolbarItem.label,
      target: self,
      action: #selector(addItemsToTranscodeQueue)
    )
    
    let menuItem: NSMenuItem = NSMenuItem()
    menuItem.submenu = nil
    menuItem.title = toolbarItem.label
    toolbarItem.menuFormRepresentation = menuItem
    
    return toolbarItem
  }
  
  func getTranscodeToolbarItem() -> NSToolbarItem {
    let toolbarItem = NSToolbarItem(itemIdentifier: .transcode)
    
    toolbarItem.label = NSLocalizedString("Transcode", comment: "")
    toolbarItem.paletteLabel = NSLocalizedString("Transcode", comment: "")
    toolbarItem.toolTip = NSLocalizedString("Transcode", comment: "")
    toolbarItem.view = NSButton(
      title: toolbarItem.label,
      target: self,
      action: #selector(addItemsToGetMetadataQueue)
    )
        
    let menuItem: NSMenuItem = NSMenuItem()
    menuItem.submenu = nil
    menuItem.title = toolbarItem.label
    toolbarItem.menuFormRepresentation = menuItem
        
    return toolbarItem
  }
  
  @objc func addItemsToTranscodeQueue() {
    addItemsToMetadataRequestQueue()
  }
  
  @objc func addItemsToGetMetadataQueue() {
    addItemsToTranscodeQueue()
  }
  
  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [
      .getMetadata,
      .space,
      .flexibleSpace,
      .transcode
    ]
  }
  
  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [
      .getMetadata,
      .flexibleSpace,
      .transcode
    ]
  }
}

private extension NSToolbarItem.Identifier {
  static let getMetadata: NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "GetMetadata")
  static let transcode: NSToolbarItem.Identifier = NSToolbarItem.Identifier(rawValue: "Transcode")
}
