import ComponentsKit
import SwiftUI

// MARK: - ViewModel

@Observable
class PaywallVM {
  enum Duration {
    case weekly
    case monthly
    case annual
  }
  
  var selectedDuration: Duration = .monthly
  var isAllPlansScreenPresented: Bool = false
  
  let allPlansModalVM = BottomModalVM {
    $0.overlayStyle = .blurred
    $0.borderWidth = .none
    $0.backgroundColor = .background
    $0.contentSpacing = 24
  }
  var weeklyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Weekly",
      price: "$9.99",
      badge: nil,
      isSelected: selectedDuration == .weekly
    )
  }
  var monthlyOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Monthly",
      price: "$19.99",
      badge: nil,
      isSelected: selectedDuration == .monthly
    )
  }
  var annualOptionVM: SubscriptionOptionVM {
    return .init(
      title: "Annual",
      price: "$199.99",
      badge: .init {
        $0.title = "Save 60%"
        $0.color = .accent
        $0.cornerRadius = .full
        $0.style = .light
        $0.font = .smButton
      },
      isSelected: selectedDuration == .annual
    )
  }
  var subscriptionSummary: String {
    let trialDuration = switch selectedDuration {
    case .weekly: "3 days"
    case .monthly: "1 week"
    case .annual: "2 weeks"
    }
    let price = switch selectedDuration {
    case .weekly: "$9.99 / week"
    case .monthly: "$19.99 / month"
    case .annual: "$199.99 / year"
    }
    return "\(trialDuration) free, then renews automatically at \(price)\nCancel anytime."
  }
  
  func didTapShowAllPlans() {
    isAllPlansScreenPresented = true
  }
  func didTapCloseAllPlans() {
    isAllPlansScreenPresented = false
  }
  func didTapWeeklyOption() {
    selectedDuration = .weekly
  }
  func didTapMonthlyOption() {
    selectedDuration = .monthly
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
  @Bindable var model = PaywallVM()
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
      
      HStack(spacing: 0) {
        Text("4.8")
          .foregroundStyle(UniversalColor.foreground.color)
          .font(UniversalFont.mdButton.font)
          .padding(.trailing, 8)
        
        ForEach(0..<5, id: \.self) { _ in
          Image("star")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundColor(.yellow)
        }
      }
      
      Text("Subscribe to Premium")
        .foregroundStyle(UniversalColor.foreground.color)
        .font(UniversalFont.lgHeadline.withSize(40).font)
        .multilineTextAlignment(.center)
        .padding(.top, 8)
      
      Text("Make the most of your experience with unlimited features and powerful tools built for productivity.")
        .font(UniversalFont.smBody.font)
        .multilineTextAlignment(.center)
        .padding(.top, 16)
        .padding(.horizontal)
      
      Spacer()
      
      Review()
      
      Spacer()
      
      Text(model.subscriptionSummary)
        .foregroundStyle(UniversalColor.secondaryForeground.color)
        .font(UniversalFont.mdCaption.font)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
      
      SUButton(
        model: .init {
          $0.title = "Start Free Trial"
          $0.color = .accent
          $0.isFullWidth = true
          $0.size = .large
        },
        action: model.didTapSubscribeButton
      )
      .padding(.top, 12)
      
      SUButton(
        model: .init {
          $0.title = "Show All Plans"
          $0.style = .plain
          $0.color = .primary
          $0.size = .large
        },
        action: model.didTapShowAllPlans
      )
      .padding(.top, 10)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(UniversalColor.background.color)
    .bottomModal(
      isPresented: $model.isAllPlansScreenPresented,
      model: model.allPlansModalVM,
      header: {
        ZStack {
          Text("Choose your plan")
            .foregroundStyle(UniversalColor.foreground.color)
            .font(UniversalFont.mdHeadline.font)
          
          HStack {
            Spacer()
            Button {
              model.didTapCloseAllPlans()
            } label: {
              Image(systemName: "xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10, height: 10)
                .foregroundColor(UniversalColor.foreground.color)
            }
            .frame(width: 24, height: 24)
            .background(UniversalColor.secondaryBackground.color)
            .clipShape(Circle())
          }
          .padding(.trailing, 8)
        }
      },
      body: {
        VStack(spacing: 8) {
          SubscriptionOption(
            model: model.weeklyOptionVM,
            didTapOption: model.didTapWeeklyOption
          )
          SubscriptionOption(
            model: model.monthlyOptionVM,
            didTapOption: model.didTapMonthlyOption
          )
          SubscriptionOption(
            model: model.annualOptionVM,
            didTapOption: model.didTapAnnualOption
          )
        }
        .animation(.linear(duration: 0.1), value: model.selectedDuration)
        .padding(.top, 2)
      }
    )
  }
}
