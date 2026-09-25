import ComponentsKit
import SwiftUI

struct SubscriptionOption: View {
  var body: some View {
    SUCard(model: .init {
      $0.backgroundColor = .accent
      $0.borderWidth = .none
      $0.cornerRadius = .small
      $0.shadow = .none
    }) {
      VStack(alignment: .leading) {
        HStack {
          Text("Pro Plan")
            .foregroundStyle(UniversalColor.accentContrast.color)
            .font(UniversalFont.lgHeadline.font)
          
          Spacer()
          
          SUBadge(model: .init {
            $0.title = "Best value"
            $0.cornerRadius = .large
            $0.color = .accent
            $0.style = .light
          })
        }
        
        Text("Everything unlocked.")
          .foregroundStyle(UniversalColor.accentContrast.color)
          .font(UniversalFont.lgCaption.font)
        
        Spacer()
        
        HStack(spacing: 8) {
          Text("$199")
            .foregroundStyle(UniversalColor.accentContrast.color)
            .font(UniversalFont.lgHeadline.font)
          
          Text("just $16.5 / month billed yearly")
            .foregroundStyle(UniversalColor.accentContrast.color)
            .font(UniversalFont.mdBody.font)
        }
      }
    }
    .frame(height: 130)
  }
}
