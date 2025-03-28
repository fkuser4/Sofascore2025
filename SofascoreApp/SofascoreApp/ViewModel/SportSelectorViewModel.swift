//
//  SportSelectorViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit

struct SportSelectorViewData {
  let selectedSport: SportType
  let underlineCenterOffset: CGFloat
  let underlineWidth: CGFloat
}

final class SportSelectorViewModel {
  private let buttonCount = SportType.allCases.count
  private let screenWidth = UIScreen.main.bounds.width
  private var buttonWidth: CGFloat { screenWidth / CGFloat(buttonCount) }
  private let underlineHorizontalPadding: CGFloat = 8.0

  private(set) var selectedSport: SportType = .football {
    didSet { notify() }
  }

  var onUpdate: ((SportSelectorViewData) -> Void)?

  func viewDidLoad() {
    notify()
  }

  func didSelect(_ sport: SportType) {
    guard selectedSport != sport else { return }
    selectedSport = sport
  }

  private func notify() {
    let buttonWidth = screenWidth / CGFloat(buttonCount)

    let centerX = CGFloat(selectedSport.index) * buttonWidth + (buttonWidth / 2)
    let offsetFromCenter = centerX - (screenWidth / 2)

    let calculatedUnderlineWidth = buttonWidth - (underlineHorizontalPadding * 2)
    let finalUnderlineWidth = max(0, calculatedUnderlineWidth)

    let data = SportSelectorViewData(
      selectedSport: selectedSport,
      underlineCenterOffset: offsetFromCenter,
      underlineWidth: finalUnderlineWidth
    )
    onUpdate?(data)
  }
}
