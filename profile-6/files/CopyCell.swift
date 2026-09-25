import ComponentsKit
import SwiftUI

// MARK: - ViewModel

struct CopyCellVM: Hashable {
  let title: String
  let value: String
  let isCopied: Bool
  
  var imageName: String {
    return isCopied ? "done" : "copy"
  }
}

// MARK: - View

struct CopyCell: View {
  let model: CopyCellVM
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .cell,
      content: {
        HStack(spacing: 8) {
          Text(model.title)
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdButton.font)
          
          Spacer()
          
          Text(model.value)
            .font(UniversalFont.mdBody.font)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
          
          Image(model.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundStyle(UniversalColor.secondaryForeground.color)
        }
        .frame(height: 44)
      },
      onTap: onTap
    )
  }
}
