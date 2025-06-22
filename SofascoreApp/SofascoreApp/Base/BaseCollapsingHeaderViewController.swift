//
//  BaseCollapsingHeaderViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit
import SnapKit
import SofaAcademic

public typealias PagerTab = (title: String, controller: UIViewController)

class BaseCollapsingHeaderViewController: UIViewController, BaseViewProtocol {
  let headerViewModel: HeaderViewModel
  let pagerTabs: [PagerTab]
  private var scrollCoordinator: ScrollCoordinator?
  var onDismiss: (() -> Void)?
  private let safeAreaView = UIView()
  private let navBar = NavigationBarView()
  private var mainCollectionView: UICollectionView?
  weak var visibleTabBarView: TabBarView?

  private let headerHeight: CGFloat = 72
  private let tabBarHeight: CGFloat = 44

  init(headerViewModel: HeaderViewModel, pagerTabs: [PagerTab]) {
    self.headerViewModel = headerViewModel
    self.pagerTabs = pagerTabs
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupDependencies()
    setupViews()
    addViews()
    styleViews()
    setupConstraints()
    setupBindings()
  }

  private func setupDependencies() {
    scrollCoordinator = ScrollCoordinator(headerHeight: headerHeight)
    scrollCoordinator?.delegate = self
  }

  private func setupViews() {
    let layout = CompositionalLayoutHelper.createCollapsingHeaderLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    registerCells(for: collectionView)
    self.mainCollectionView = collectionView
  }

  private func registerCells(for collectionView: UICollectionView?) {
    guard let collectionView = collectionView else { return }
    collectionView.register(
      CollapsingHeaderCell.self,
      forCellWithReuseIdentifier: CollapsingHeaderCell.reuseIdentifier
    )
    collectionView.register(
      PagerContainerCell.self,
      forCellWithReuseIdentifier: PagerContainerCell.reuseIdentifier
    )
    collectionView.register(
      TabBarCollectionReuseableView.self,
      forSupplementaryViewOfKind: "TabBar",
      withReuseIdentifier: TabBarCollectionReuseableView.reuseIdentifier
    )
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(navBar)
    guard let mainCollectionView = mainCollectionView else { return }
    view.addSubview(mainCollectionView)
  }

  func styleViews() {
    view.backgroundColor = .contentBackground
    safeAreaView.backgroundColor = .primaryBackgroundColor
    navBar.configure(with: hideNavBarTitleConfig)
    mainCollectionView?.backgroundColor = .clear
    mainCollectionView?.showsVerticalScrollIndicator = false
    mainCollectionView?.bounces = false
  }

  func setupConstraints() {
    safeAreaView.snp.makeConstraints {
      $0.top.equalTo(view)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
    navBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    mainCollectionView?.snp.makeConstraints {
      $0.top.equalTo(navBar.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  func setupBindings() {
    navBar.didTapBackButton = { [weak self] in self?.onDismiss?() }
  }

  private func updateNavigationBar(for yOffset: CGFloat) {
    let threshold = headerHeight - (navigationController?.navigationBar.frame.height ?? 0) + 20
    let config = yOffset > threshold ? showNavBarTitleConfig : hideNavBarTitleConfig
    navBar.configure(with: config)
  }

  private var showNavBarTitleConfig: NavigationBarConfiguration {
    NavigationBarConfiguration(
      title: headerViewModel.title,
      backIconColor: .backIconOnBlue,
      backgroundColor: .primaryBackgroundColor
    )
  }
  private let hideNavBarTitleConfig = NavigationBarConfiguration(
    title: "",
    backIconColor: .backIconOnBlue,
    backgroundColor: .primaryBackgroundColor
  )
}

extension BaseCollapsingHeaderViewController: PagerContainerCellDelegate {
  func pagerDidSwitchToPage(at index: Int) {
    visibleTabBarView?.selectItem(at: index)
  }

  func pagerIsBeingSwiped(from fromIndex: Int, to toIndex: Int, progress: CGFloat) {
    scrollCoordinator?.pagerIsBeingSwiped(from: fromIndex, to: toIndex, progress: progress)
  }

  func pagerContentDidScroll(with offset: CGPoint) {
    scrollCoordinator?.pagerContentDidScroll(yOffset: offset.y)
  }
}

extension BaseCollapsingHeaderViewController: ScrollCoordinatorDelegate {
  func scrollCoordinatorDidRequestNavBarUpdate(for yOffset: CGFloat) {
    updateNavigationBar(for: yOffset)
  }

  func scrollCoordinatorDidRequestTabBarUpdate(from fromIndex: Int, to toIndex: Int, progress: CGFloat) {
    visibleTabBarView?.updateUnderlinePosition(from: fromIndex, to: toIndex, progress: progress)
  }

  func scrollCoordinatorDidRequestMainScrollUpdate(to yOffset: CGFloat) {
    mainCollectionView?.setContentOffset(CGPoint(x: 0, y: yOffset), animated: false)
  }
}

extension BaseCollapsingHeaderViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: CollapsingHeaderCell.reuseIdentifier,
        for: indexPath) as? CollapsingHeaderCell else {
        return UICollectionViewCell()
      }

      cell.configure(with: headerViewModel)
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PagerContainerCell.reuseIdentifier,
        for: indexPath) as? PagerContainerCell else {
        return UICollectionViewCell()
      }

      cell.delegate = self
      cell.configure(with: pagerTabs, parentViewController: self)
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == "TabBar" else { return UICollectionReusableView() }

    guard let reusableView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: TabBarCollectionReuseableView.reuseIdentifier,
      for: indexPath
    ) as? TabBarCollectionReuseableView else {
      return UICollectionReusableView()
    }

    reusableView.configure(with: pagerTabs.map { TabBarItem(title: $0.title, iconName: nil) })
    return reusableView
  }
}

extension BaseCollapsingHeaderViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollCoordinator?.mainScrollViewDidScroll(yOffset: scrollView.contentOffset.y)
  }

  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    guard let tabBarReusableView = view as? TabBarCollectionReuseableView else { return }

    self.visibleTabBarView = tabBarReusableView.tabBarView
    tabBarReusableView.onTabSelected = { [weak self] index in
      guard let self = self,
        let cell = self.mainCollectionView?.cellForItem(at: IndexPath(item: 0, section: 1)) as? PagerContainerCell
      else {
        return
      }

      cell.scrollToPage(index, animated: true)
    }
  }
}
