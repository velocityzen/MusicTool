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
    setStoredSystemMode()
    
    // Create the SwiftUI view that provides the window contents.
    let rootView = StoreProvider(store: store) {
      Main()
    }

    // Create the window and set the content view. 
    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView, .unifiedTitleAndToolbar],
      backing: .buffered,
      defer: false
    )
    
    window.center()
    window.setFrameAutosaveName("Music Tool")
    window.contentView = NSHostingView(rootView: rootView)
    window.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  func setStoredSystemMode() {
    switch Defaults[.theme] {
      case .Dark:
        NSApp.appearance = NSAppearance(named: .darkAqua)
      case .Light:
        NSApp.appearance = NSAppearance(named: .aqua)
      default:
        NSApp.appearance = nil
    }
    
    showSelectedModeInMenu()
  }
  
  func showSelectedModeInMenu() {
    switch Defaults[.theme] {
      case .Dark:
        darkModeMenuItem.state = .on
        lightModeMenuItem.state = .off
        systemModeMenuItem.state = .off
      case .Light:
        darkModeMenuItem.state = .off
        lightModeMenuItem.state = .on
        systemModeMenuItem.state = .off
      default:
        darkModeMenuItem.state = .off
        lightModeMenuItem.state = .off
        systemModeMenuItem.state = .on
    }
  }
  
  @IBAction func darkModeSelected(_ sender: Any) {
    NSApp.appearance = NSAppearance(named: .darkAqua)
    Defaults[.theme] = .Dark
    showSelectedModeInMenu()
  }
  
  @IBAction func lightModeSelected(_ sender: Any) {
    NSApp.appearance = NSAppearance(named: .aqua)
    Defaults[.theme] = .Light
    showSelectedModeInMenu()
  }
  
  @IBAction func systemModeSelected(_ sender: Any) {
    NSApp.appearance = nil
    Defaults[.theme] = .System
    showSelectedModeInMenu()
  }
}


let store = Store<AppState>(reducer: appStateReducer,
                            state: AppState(albums: AlbumsState())
)
