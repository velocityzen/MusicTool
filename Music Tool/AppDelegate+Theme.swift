import Cocoa
import Defaults

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
