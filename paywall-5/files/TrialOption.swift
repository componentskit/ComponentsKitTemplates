import ComponentsKit
import SwiftUI

struct TrialOption: View {
  @Binding var isTrialSelected: Bool
  
  var body: some View {
    SUCard(
      model: .init {
        $0.animationScale = .none
        $0.backgroundColor = .secondaryBackground
        $0.borderWidth = .none
        $0.cornerRadius = .small
        $0.contentPaddings = .init(horizontal: 16, vertical: 0)
        $0.isTappable = true
        $0.shadow = .none
      },
      content: {
        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text(isTrialSelected ? "Free trial enabled" : "Not sure yet?")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.mdButton.font)
            
            if !isTrialSelected {
              Text("Try 7 days trial for free")
                .foregroundStyle(UniversalColor.foreground.color)
                .font(UniversalFont.smBody.font)
            }
          }
          
          Spacer()
          
          SUCheckbox(isSelected: .constant(isTrialSelected))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 64)
      },
      onTap: { isTrialSelected.toggle() }
    )
  }
}
