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

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    addViews()
    setupConstraints()
    setupBindings()
    sportSelectorView.configure(with: sportTypes, initialSport: initialSport)
    eventsViewModel.selectSport(initialSport)
  }

  func addViews() {
    view.addSubview(sportSelectorView)
    view.addSubview(containerView)

    addChild(eventsVC)
    containerView.addSubview(eventsVC.view)
    eventsVC.didMove(toParent: self)
  }

  func setupConstraints() {
    sportSelectorView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
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

  private func setupBindings() {
    sportSelectorView.onTap = { [weak self] sport in
      guard let self = self else { return }
      self.eventsViewModel.selectSport(sport)
    }
  }
}
