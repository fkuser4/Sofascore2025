//
//  PagerContainerCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit
import SnapKit

final class PagerContainerCell: UICollectionViewCell {
  static let reuseIdentifier = "PagerContainerCell"
  weak var delegate: PagerContainerCellDelegate?

  private let pageViewController: UIPageViewController
  private var controllers: [UIViewController] = []
  private var currentIndex = 0
  private var isTapDrivenScroll = false

  override init(frame: CGRect) {
    let pvc = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal,
      options: nil
    )
    self.pageViewController = pvc
    super.init(frame: frame)
    backgroundColor = .white
    pageViewController.dataSource = self
    pageViewController.delegate = self
    contentView.addSubview(pageViewController.view)
    pageViewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    self.setupScrollViewDelegate()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with tabs: [PagerTab], parentViewController: UIViewController) {
    self.controllers = tabs.map { $0.controller }
    parentViewController.addChild(pageViewController)
    pageViewController.didMove(toParent: parentViewController)
    setupScrollObservation()
    if let firstController = controllers.first {
      pageViewController.setViewControllers(
        [firstController], direction: .forward, animated: false
      )
    }
  }

  func scrollToPage(_ index: Int, animated: Bool) {
    guard index < controllers.count, index != currentIndex else { return }
    isTapDrivenScroll = true
    let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse
    currentIndex = index
    pageViewController.setViewControllers(
      [controllers[index]],
      direction: direction,
      animated: animated
    ) { [weak self] completed in
      if completed {
        self?.isTapDrivenScroll = false
      }
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    pageViewController.willMove(toParent: nil)
    pageViewController.removeFromParent()
    pageViewController.view.removeFromSuperview()
    contentView.addSubview(pageViewController.view)
    pageViewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    pageViewController.setViewControllers([], direction: .forward, animated: false)
    delegate = nil
    controllers.removeAll()
    currentIndex = 0
    isTapDrivenScroll = false
  }

  private func setupScrollViewDelegate() {
    pageViewController.view.subviews.compactMap { $0 as? UIScrollView }.first?.delegate = self
  }

  private func setupScrollObservation() {
    controllers.forEach { controller in
      controller.view.subviews.forEach { findAndObserveScrollViews(in: $0) }
    }
  }

  private func findAndObserveScrollViews(in view: UIView) {
    if let scrollView = view as? UIScrollView {
      observeScrollView(scrollView)
    }
    view.subviews.forEach { findAndObserveScrollViews(in: $0) }
  }

  private func observeScrollView(_ scrollView: UIScrollView) {
    let originalDelegate = scrollView.delegate
    let wrapper = ScrollDelegateWrapper(
      originalDelegate: originalDelegate) { [weak self] offset in
      self?.delegate?.pagerContentDidScroll(with: offset)
    }

    scrollView.delegate = wrapper
    objc_setAssociatedObject(scrollView, &AssociatedKeys.scrollDelegateWrapper, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

extension PagerContainerCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
    return controllers[index - 1]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = controllers.firstIndex(of: viewController), index < controllers.count - 1 else { return nil }
    return controllers[index + 1]
  }

  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    guard completed,
      let currentVC = pageViewController.viewControllers?.first,
      let index = controllers.firstIndex(of: currentVC)
    else { return }
    currentIndex = index
    delegate?.pagerDidSwitchToPage(at: index)
  }
}

extension PagerContainerCell: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard !isTapDrivenScroll else { return }
    let width = scrollView.frame.width
    guard width > 0 else { return }
    let delta = scrollView.contentOffset.x - width
    let progress = abs(delta) / width
    guard progress > .ulpOfOne && progress < 1 else { return }
    if delta > 0 {
      let fromIndex = currentIndex
      let toIndex = currentIndex + 1
      guard toIndex < controllers.count else { return }
      delegate?.pagerIsBeingSwiped(from: fromIndex, to: toIndex, progress: progress)
    } else {
      let fromIndex = currentIndex
      let toIndex = currentIndex - 1
      guard toIndex >= 0 else { return }
      delegate?.pagerIsBeingSwiped(from: fromIndex, to: toIndex, progress: progress)
    }
  }
}

private class ScrollDelegateWrapper: NSObject, UIScrollViewDelegate {
  weak var originalDelegate: UIScrollViewDelegate?
  let onScroll: (CGPoint) -> Void

  init(originalDelegate: UIScrollViewDelegate?, onScroll: @escaping (CGPoint) -> Void) {
    self.originalDelegate = originalDelegate
    self.onScroll = onScroll
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    onScroll(scrollView.contentOffset)
    originalDelegate?.scrollViewDidScroll?(scrollView)
  }

  override func responds(to aSelector: Selector?) -> Bool {
    guard let aSelector = aSelector else {
      return false
    }
    if super.responds(to: aSelector) {
      return true
    }
    return originalDelegate?.responds(to: aSelector) ?? false
  }

  override func forwardingTarget(for aSelector: Selector?) -> Any? {
    guard let aSelector = aSelector else {
      return super.forwardingTarget(for: nil)
    }
    if originalDelegate?.responds(to: aSelector) ?? false {
      return originalDelegate
    }
    return super.forwardingTarget(for: aSelector)
  }
}

private struct AssociatedKeys {
  static var scrollDelegateWrapper = "scrollDelegateWrapper"
}
