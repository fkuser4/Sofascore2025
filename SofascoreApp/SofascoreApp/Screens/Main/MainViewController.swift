//
//  ViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 09.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class MainViewController: UIViewController, BaseViewProtocol {
  private let tabBarView = TabBarView()
  private let sportTypes: [SportType] = [.football, .basketball, .americanFootball]
  private let eventsViewModel: EventsViewModel = .init(initialSport: .football)
  private lazy var eventsVC = EventsViewController(viewModel: eventsViewModel)
  private let safeAreaView: UIView = .init()
  private let headerView = MainHeaderView()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .contentBackground

    addViews()
    setupConstraints()
    setupBindings()
    styleViews()

    let items = sportTypes.map { sport in
      TabBarItem(title: sport.title, iconName: sport.iconName)
    }
    tabBarView.configure(with: items)
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(headerView)
    view.addSubview(tabBarView)

    addChild(eventsVC)
    view.addSubview(eventsVC.view)
    eventsVC.didMove(toParent: self)
  }

  func setupConstraints() {
    safeAreaView.snp.makeConstraints {
      $0.top.equalTo(view)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
    }

    headerView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }

    tabBarView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }

    eventsVC.view.snp.makeConstraints {
      $0.top.equalTo(tabBarView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  func styleViews() {
    safeAreaView.backgroundColor = .primaryBackgroundColor
  }

  private func setupBindings() {
    tabBarView.onItemSelected = { [weak self] selectedIndex in
      guard let self = self else { return }
      let selectedSport = self.sportTypes[selectedIndex]
      self.eventsViewModel.selectSport(selectedSport)
    }

    headerView.didTapSettingsButton = { [weak self] in
      guard let self = self else { return }
      let settingsVC = SettingsViewController()
      settingsVC.onDismiss = {
        self.dismiss(animated: true)
      }
      settingsVC.modalPresentationStyle = .fullScreen
      self.present(settingsVC, animated: true)
    }
  }
}
