//
//  ScrollCoordinator.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import Foundation
import UIKit

final class ScrollCoordinator {
  weak var delegate: ScrollCoordinatorDelegate?

  private let headerHeight: CGFloat
  private var isScrollingPagerContent = false

  init(headerHeight: CGFloat) {
    self.headerHeight = headerHeight
  }

  func mainScrollViewDidScroll(yOffset: CGFloat) {
    guard !isScrollingPagerContent else { return }
    delegate?.scrollCoordinatorDidRequestNavBarUpdate(for: yOffset)
  }

  func pagerContentDidScroll(yOffset: CGFloat) {
    guard !isScrollingPagerContent else { return }
    isScrollingPagerContent = true

    let maxOffset = headerHeight
    let adjustedOffset = min(max(yOffset, 0), maxOffset)

    delegate?.scrollCoordinatorDidRequestMainScrollUpdate(to: adjustedOffset)
    delegate?.scrollCoordinatorDidRequestNavBarUpdate(for: yOffset)

    DispatchQueue.main.async { [weak self] in
      self?.isScrollingPagerContent = false
    }
  }

  func pagerIsBeingSwiped(from fromIndex: Int, to toIndex: Int, progress: CGFloat) {
    delegate?.scrollCoordinatorDidRequestTabBarUpdate(from: fromIndex, to: toIndex, progress: progress)
  }
}
