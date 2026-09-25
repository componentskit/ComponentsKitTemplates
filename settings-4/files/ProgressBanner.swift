import ComponentsKit
import SwiftUI

struct ProgressBanner: View {
  let progress: CGFloat
  let onTap: () -> Void
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .small
        $0.backgroundColor = .accentBackground
        $0.shadow = .none
        $0.borderColor = .accent
        $0.cornerRadius = .small
        $0.isTappable = true
      },
      content: {
        HStack(spacing: 16) {
          SUCircularProgress(model: .init {
            $0.size = .medium
            $0.currentValue = progress
            $0.lineWidth = 6
            $0.color = .init(
              main: .accent,
              contrast: .accentContrast,
              background: .content1
            )
            $0.label = "\(Int(progress))%"
            $0.font = .mdCaption
          })
          
          VStack(alignment: .leading, spacing: 8) {
            Text("Finish Setup")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdHeadline.font)
            
            Text("Make the most out of your account")
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdBody.font)
          }
          
          Spacer()
          
          Image(systemName: "chevron.right")
            .foregroundStyle(UniversalColor.accent.color)
        }
      },
      onTap: onTap
    )
  }
}
