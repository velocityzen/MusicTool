import Cocoa
import Defaults

enum Theme: String, Codable {
  case Dark = "dark"
  case Light = "light"
  case System = "system"
}

extension Defaults.Keys {
  static let theme = Key<Theme>("theme", default: .System)
}
