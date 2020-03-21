import Foundation
import SwiftUI

struct AsyncImageTransition<Placeholder: View>: View {
  var image: Image?
  var placeholder: Placeholder?
    
  public var body: some View {
    ZStack {
      if image == nil {
        placeholder
          .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.15)))
      }
      
      image?.transition(AnyTransition.opacity.animation(.easeOut(duration: 0.15)))
    }
  }
}
