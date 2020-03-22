import SwiftUI

struct DropView: View {
  var body: some View {
    Text("Drag and Drop your files and folders here")
      .font(.headline)
      .foregroundColor(.secondary)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
