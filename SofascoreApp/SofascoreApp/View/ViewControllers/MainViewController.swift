//
//  ViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 09.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class MainViewController: UIViewController {
  private let sportSelectorView = SportSelectorView()
  private let mainViewModel = MainViewModel()

  private let containerView = UIView()
  private lazy var eventsVC = EventsViewController(viewModel: mainViewModel)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupSubviews()
    setupConstraints()
    setupBindings()

    mainViewModel.tabChange(to: .football)
  }

  private func setupSubviews() {
    view.addSubview(sportSelectorView)
    view.addSubview(containerView)

    addChild(eventsVC)
    containerView.addSubview(eventsVC.view)
    eventsVC.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    eventsVC.didMove(toParent: self)
  }

  private func setupConstraints() {
    sportSelectorView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }

    containerView.snp.makeConstraints {
      $0.top.equalTo(sportSelectorView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func setupBindings() {
    sportSelectorView.configure(with: SportType.allCases)
    sportSelectorView.onTap = { [weak self] sport in
      self?.mainViewModel.tabChange(to: sport)
    }
  }
}
