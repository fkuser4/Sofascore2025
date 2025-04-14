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
  private let sportSelectorView = SportSelectorView()
  private let sportTypes: [SportType] = [.football, .basketball, .americanFootball]
  private let initialSport: SportType = .football
  private let containerView = UIView()
  private let eventsViewModel: EventsViewModel = .init()
  private lazy var eventsVC = EventsViewController(viewModel: eventsViewModel)
  private let safeAreaView: UIView = .init()
  private let headerView = HeaderView()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    addViews()
    setupConstraints()
    setupBindings()
    styleViews()
    sportSelectorView.configure(with: sportTypes, initialSport: initialSport)
    eventsViewModel.selectSport(initialSport)
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(headerView)
    view.addSubview(sportSelectorView)
    view.addSubview(containerView)

    addChild(eventsVC)
    containerView.addSubview(eventsVC.view)
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

    sportSelectorView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }

    containerView.snp.makeConstraints {
      $0.top.equalTo(sportSelectorView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }

    eventsVC.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func styleViews() {
    safeAreaView.backgroundColor = .primaryBackgroundColor
  }

  private func setupBindings() {
    sportSelectorView.onTap = { [weak self] sport in
      guard let self = self else { return }
      self.eventsViewModel.selectSport(sport)
    }

    headerView.didTapSettingsButton = { [weak self] in
      guard let self = self else { return }
      let settingsVC = SettingsViewController()
      settingsVC.dismissVC = {
        self.navigationController?.popViewController(animated: true)
      }
      settingsVC.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(settingsVC, animated: true)
    }
  }
}
