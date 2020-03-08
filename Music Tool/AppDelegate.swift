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

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  @IBOutlet weak var lightModeMenuItem: NSMenuItem!
  @IBOutlet weak var darkModeMenuItem: NSMenuItem!
  @IBOutlet weak var systemModeMenuItem: NSMenuItem!
  
  var window: NSWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    setTheme()
    
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
        .fullSizeContentView
      ],
      backing: .buffered,
      defer: false
    )
    
    window.center()
    window.setFrameAutosaveName("Music Tool Main Window")
    window.title = "Music Tool"
    window.titleVisibility = .hidden
    window.contentView = NSHostingView(rootView: rootView)
    
    self.initToolbar()
    
    window.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}

// Theme menu selector
extension AppDelegate {
  @IBAction func darkModeSelected(_ sender: Any) {
    setTheme(.Dark)
  }
  
  @IBAction func lightModeSelected(_ sender: Any) {
    setTheme(.Light)
  }
  
  @IBAction func systemModeSelected(_ sender: Any) {
    setTheme(.System)
  }
  
  func setTheme(_ theme: Theme? = nil) {
    if let t = theme {
      Defaults[.theme] = t
    }
    
    switch Defaults[.theme] {
      case .Dark:
        NSApp.appearance = NSAppearance(named: .darkAqua)
        darkModeMenuItem.state = .on
        lightModeMenuItem.state = .off
        systemModeMenuItem.state = .off
      case .Light:
        NSApp.appearance = NSAppearance(named: .aqua)
        darkModeMenuItem.state = .off
        lightModeMenuItem.state = .on
        systemModeMenuItem.state = .off
      default:
        NSApp.appearance = nil
        darkModeMenuItem.state = .off
        lightModeMenuItem.state = .off
        systemModeMenuItem.state = .on
    }
  }
}

