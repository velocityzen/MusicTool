//
//  AppDelegate.swift
//  Music Tool
//
//  Created by velocityzen on 11/29/19.
//  Copyright © 2019 velocityzen. All rights reserved.
//

import Cocoa
import SwiftUI
import SwiftUIFlux
import Defaults
import Combine

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  @IBOutlet weak var lightModeMenuItem: NSMenuItem!
  @IBOutlet weak var darkModeMenuItem: NSMenuItem!
  @IBOutlet weak var systemModeMenuItem: NSMenuItem!
  
  var window: NSWindow!
  var workersSubscription: AnyCancellable!
  var filesParsingSubscription: AnyCancellable!
  var toolbarSubscription: AnyCancellable!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    setTheme()
    workersSubscription = initWorkersSubjects()
    filesParsingSubscription = initFileParsingSubscription()
    
    // Create the SwiftUI view that provides the window contents.
    let rootView = StoreProvider(store: store) {
      Main()
    }

    // Create the window and set the content view. 
    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
      styleMask: [
        .titled,
        .closable,
        .miniaturizable,
        .resizable,
        .fullSizeContentView,
        .unifiedTitleAndToolbar
      ],
      backing: .buffered,
      defer: false
    )
    
    window.center()
    window.setFrameAutosaveName("Music Tool Main Window")
    window.collectionBehavior.insert(.fullScreenPrimary)
    window.title = "Music Tool"
    window.titleVisibility = .hidden
    window.contentView = NSHostingView(rootView: rootView)
    
    self.initToolbar()
    
    window.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    toolbarSubscription = nil
    workersSubscription = nil
    filesParsingSubscription = nil
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}

