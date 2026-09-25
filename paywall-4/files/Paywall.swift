import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class PaywallVM {
  enum Duration {
    case weekly
    case annual
  }
  
  var selectedDuration: Duration = .weekly
  
  var weeklyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Weekly",
      price: "$3.99",
      pricePerWeek: "$3.99 / week",
      isSelected: selectedDuration == .weekly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Annual",
      price: "$79.99",
      pricePerWeek: "only $1.54 / week",
      isSelected: selectedDuration == .annual
    )
  }
  var subscriptionSummary: String {
    let trialDuration = switch selectedDuration {
    case .weekly: "3 days"
    case .annual: "7 days"
    }
    let price = switch selectedDuration {
    case .weekly: "$3.99 / week"
    case .annual: "$79.99 / year"
    }
    return "\(trialDuration) free, then renews automatically at \(price). Cancel anytime."
  }
  
  func didTapWeeklyOption() {
    selectedDuration = .weekly
  }
  func didTapAnnualOption() {
    selectedDuration = .annual
  }
  func didTapSubscribeButton() {
    /* handle subscribe button tap */
  }
}

// MARK: - View

struct Paywall: View {
  let model = PaywallVM()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack(alignment: .top) {
      Image("background")
        .resizable()
        .aspectRatio(contentMode: .fit)
      
      VStack {
        HStack {
          Spacer()
          SUButton(model: .init {
            $0.color = .init(main: .background, contrast: .accent)
            $0.cornerRadius = .full
            $0.image = .init(systemName: "xmark")
            $0.size = .small
            $0.style = .filled
          }) {
            dismiss()
          }
        }
        
        Spacer()
        
        SUCard(model: .init {
          $0.borderWidth = .none
          $0.cornerRadius = .large
          $0.shadow = .none
        }) {
          VStack(spacing: 8) {
            Text("PREMIUM")
              .font(UniversalFont.smButton.font)
              .foregroundStyle(UniversalColor.accent.color)
              .multilineTextAlignment(.center)
            
            Text("Get access to Pro features")
              .foregroundStyle(UniversalColor.foreground.color)
              .font(UniversalFont.lgHeadline.withSize(32).font)
              .multilineTextAlignment(.center)
            
            HStack {
              SubscriptionOption(
                model: model.weeklyOptionVM,
                didTapOption: model.didTapWeeklyOption
              )
              SubscriptionOption(
                model: model.annualOptionVM,
                didTapOption: model.didTapAnnualOption
              )
            }
            .padding(.top, 16)
            .animation(.linear(duration: 0.1), value: model.selectedDuration)
            
            SUButton(
              model: .init {
                $0.title = "Continue"
                $0.color = .accent
                $0.isFullWidth = true
                $0.cornerRadius = .large
                $0.size = .large
              },
              action: model.didTapSubscribeButton
            )
            .padding(.top, 16)
            
            Text(model.subscriptionSummary)
              .foregroundStyle(UniversalColor.secondaryForeground.color)
              .font(UniversalFont.mdCaption.font)
              .multilineTextAlignment(.center)
              .padding(.top, 4)
          }
        }
      }
      .padding()
    }
    .frame(maxWidth: .infinity)
    .background(UniversalColor.accentBackground.color)
  }
}
