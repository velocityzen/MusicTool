import SwiftUI

struct Grid<Content>: View where Content: View{
  private let cols: Int
  private let rows: Int
  private let itemsCount: Int
  private let hasHangedItems: Bool
  private let content: (Int) -> Content
  
  
  init(
    geometry: GeometryProxy,
    itemsCount: Int,
    itemWidth: CGFloat,
    @ViewBuilder content: @escaping (Int) -> Content
  ) {
    self.cols = getCols(geometry, itemWidth: itemWidth, itemsCount: itemsCount)
    self.rows = getRows(itemsCount: itemsCount, columns: self.cols)
    self.itemsCount = itemsCount
    self.content = content
    self.hasHangedItems = self.itemsCount % self.cols != 0
  }
  
  var body: some View {
    VStack() {
      ForEach((0..<self.rows), id: \.self) { row in
        HStack {
          ForEach((0..<((
            row == self.rows - 1 &&
            self.hasHangedItems ?
             self.itemsCount % self.cols : self.cols))
          ), id: \.self) { col in
            self.content(row * self.cols + col)
          }
          
          if self.hasHangedItems {
            Spacer()
          }
        }
      }
    }
  }
}

private func getCols(_ geometry: GeometryProxy, itemWidth: CGFloat, itemsCount: Int) -> Int {
  return max(1, min(Int(geometry.size.width / itemWidth), itemsCount))
}

private func getRows(itemsCount: Int, columns: Int) -> Int {
  let rows = Double(itemsCount) / Double(columns)
  return max(Int(rows.rounded(.up)), 1)
}
