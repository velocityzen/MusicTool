import SwiftUI

struct Grid<Content>: View where Content: View{
  private let cols: Int
  private let rows: Int
  private let itemsCount: Int
  private let padding: CGFloat
  private let hasHangedItems: Bool
  private let maxRowWidth: CGFloat
  private let content: (Int) -> Content
    
  init(
    geometry: GeometryProxy,
    itemsCount: Int,
    itemWidth: CGFloat,
    padding: CGFloat,
    @ViewBuilder content: @escaping (Int) -> Content
  ) {
    self.cols = getCols(geometry, itemWidth: itemWidth, padding: padding, itemsCount: itemsCount)
    self.rows = getRows(itemsCount: itemsCount, columns: self.cols)
    self.itemsCount = itemsCount
    self.padding = padding
    self.content = content
    self.hasHangedItems = self.itemsCount % self.cols != 0
    self.maxRowWidth = CGFloat(self.cols) * itemWidth
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach((0..<self.rows), id: \.self) { row in
        HStack(spacing: 0) {
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
        .frame(maxWidth: self.maxRowWidth)
      }
    }
    .frame(maxWidth: .infinity)
    .padding(EdgeInsets(top: self.padding, leading: self.padding, bottom: 0, trailing: self.padding))
  }
}

private func getCols(_ geometry: GeometryProxy, itemWidth: CGFloat, padding: CGFloat, itemsCount: Int) -> Int {
  return max(
    1,
    min(
      Int(
        (geometry.size.width - padding  - padding) / itemWidth
      ),
      itemsCount
    )
  )
}

private func getRows(itemsCount: Int, columns: Int) -> Int {
  let rows = Double(itemsCount) / Double(columns)
  return max(Int(rows.rounded(.up)), 1)
}
