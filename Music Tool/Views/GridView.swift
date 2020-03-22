import SwiftUI

struct GridView<Content, DataType>: DynamicViewContent where Content: View, DataType: Identifiable {
  typealias Data = OrderedSet<DataType>
  typealias ContentViewBuilder = (DataType) -> Content
    
  var data: Data
  let itemWidth: CGFloat
  let padding: CGFloat
  let content: ContentViewBuilder
  
  init(_ data: Data, itemWidth: CGFloat, padding: CGFloat, content: @escaping ContentViewBuilder) {
    self.data = data
    self.itemWidth = itemWidth
    self.padding = padding
    self.content = content
  }
  
  var body: some View {
    GeometryReader { geometry in
      self.gridView(geometry)
        .padding(self.padding)
        .frame(maxWidth: .infinity)
    }
  }
  
  private func gridView(_ geometry: GeometryProxy) -> some View {
    let boundaries = calculateBoundaries(geometry)
    print("size: \(geometry.size), boundaries: \(boundaries)")
    
    return VStack(spacing: 0) {
      ForEach((0..<boundaries.rows), id: \.self) { row in
        self.rowView(
          row: row,
          rows: boundaries.rows,
          columns: boundaries.columns,
          hangedItems: boundaries.hangedItems
        )
      }
    }
    .frame(maxWidth: boundaries.maxRowWidth)
  }
  
  private func rowView(row: Int, rows: Int, columns: Int, hangedItems: Int) -> some View {
    HStack(spacing: 0) {
      ForEach((0..<((
        row == rows - 1 && hangedItems > 0 ? hangedItems : columns))
      ), id: \.self) { col in
        self.content(self.data[row * columns + col])
      }
    }
  }
}

extension GridView {
  private func calculateBoundaries(_ geometry: GeometryProxy) -> (columns: Int, rows: Int, maxRowWidth: CGFloat, hangedItems: Int) {
    let columns = getCols(geometry, itemWidth: itemWidth, padding: padding)
    let rows = getRows(columns: columns)
    let hangedItems = self.data.count % columns
    let maxRowWidth = CGFloat(columns) * self.itemWidth
    
    return ( columns, rows, maxRowWidth, hangedItems)
  }

  private func getCols(_ geometry: GeometryProxy, itemWidth: CGFloat, padding: CGFloat) -> Int {
    return max(
      1,
      min(
        Int(
          (geometry.size.width - padding  - padding) / itemWidth
        ),
        self.data.count
      )
    )
  }

  private func getRows(columns: Int) -> Int {
    let rows = Double(self.data.count) / Double(columns)
    return max(Int(rows.rounded(.up)), 1)
  }
}
