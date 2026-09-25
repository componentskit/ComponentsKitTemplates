import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class PaywallVM {
  let benefitTitles = [
    "Daily tools that actually work",
    "Features you didn’t know you needed",
    "Updates that keep getting better"
  ]
  
  func didTapSubscribeButton() {
    /* handle subscribe button tap */
  }
}

// MARK: - View

struct Paywall: View {
  let model = PaywallVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Spacer()
        SUButton(model: .init {
          $0.image = .init(systemName: "xmark")
          $0.color = .accent
          $0.style = .minimal
          $0.size = .small
        }) {
          dismiss()
        }
      }
      
      Spacer()
      
      SUCard(model: .init {
        $0.backgroundColor = .accentBackground
        $0.borderWidth = .none
        $0.contentPaddings = .init(padding: 24)
        $0.cornerRadius = .large
        $0.shadow = .none
      }) {
        Image("star-stroke")
          .renderingMode(.template)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 40, height: 40)
          .foregroundColor(UniversalColor.accent.color)
      }
      
      Text("Get access to Pro features")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.withSize(32).font)
        .multilineTextAlignment(.center)
        .padding(.top, 24)
      
      Text("Get more done, with less effort. Upgrade to Pro and enjoy the smoothest, fastest, smartest experience we’ve got.")
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.smBody.font)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .padding(.top, 12)
      
      Spacer()
      
      VStack(spacing: 12) {
        ForEach(model.benefitTitles, id: \.self) { title in
          SubscriptionBenefit(title: title)
        }
      }
      
      Spacer()
      
      SubscriptionOption()
      
      Spacer()
      
      SUButton(
        model: .init {
          $0.title = "Start 7 days free trial"
          $0.color = .accent
          $0.isFullWidth = true
          $0.size = .large
        },
        action: model.didTapSubscribeButton
      )
      
      Text("7 days free, then renews automatically at $199.99 / year. Cancel anytime.")
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.mdCaption.font)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(UniversalColor.background.color)
  }
}
