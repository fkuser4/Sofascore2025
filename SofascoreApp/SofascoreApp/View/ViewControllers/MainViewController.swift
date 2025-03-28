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
  private let underlineTrackView = UIView()
  private let underlineView = UIView()
  private let containerView = UIView()
  private let sportViewModel = SportSelectorViewModel()

  private lazy var footballVC = FootballEventsViewController()
  private lazy var basketballVC = BasketballEventsViewController()
  private lazy var americanFootballVC = AmericanFootballEventsViewController()

  private var currentChildVC: UIViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupSubviews()
    setupConstraints()
    setupStyles()
    setupBindings()

    sportViewModel.viewDidLoad()
    switchToChildViewController(newVC: footballVC)
  }

  private func setupSubviews() {
    view.addSubview(sportSelectorView)
    view.addSubview(underlineTrackView)
    underlineTrackView.addSubview(underlineView)
    view.addSubview(containerView)
  }

  private func setupConstraints() {
    sportSelectorView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }

    underlineTrackView.snp.makeConstraints {
      $0.top.equalTo(sportSelectorView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(4)
    }

    underlineView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.width.equalTo(0)
    }

    containerView.snp.makeConstraints {
      $0.top.equalTo(underlineTrackView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func setupStyles() {
    underlineTrackView.backgroundColor = .sportSelectorBackground

    underlineView.backgroundColor = .sportSelectorText
    underlineView.layer.cornerRadius = 2
    underlineView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    underlineView.clipsToBounds = true
    underlineView.isUserInteractionEnabled = false
  }

  private func setupBindings() {
    sportSelectorView.configure(with: SportType.allCases)
    sportSelectorView.onTap = { [weak self] sport in
      self?.sportViewModel.didSelect(sport)
      self?.switchToSport(sport: sport)
    }

    sportViewModel.onUpdate = { [weak self] data in
      self?.underlineView.snp.updateConstraints {
        $0.centerX.equalToSuperview().offset(data.underlineCenterOffset)
        $0.width.equalTo(data.underlineWidth)
      }
      UIView.animate(withDuration: 0.25) {
        self?.view.layoutIfNeeded()
      }
    }
  }

  private func switchToSport(sport: SportType) {
    switch sport {
    case .football:
      switchToChildViewController(newVC: footballVC)
    case .basketball:
      switchToChildViewController(newVC: basketballVC)
    case .americanFootball:
      switchToChildViewController(newVC: americanFootballVC)
    }
  }

  private func switchToChildViewController(newVC: UIViewController) {
    if let currentVC = currentChildVC {
      currentVC.willMove(toParent: nil)
      currentVC.view.removeFromSuperview()
      currentVC.removeFromParent()
    }

    addChild(newVC)
    containerView.addSubview(newVC.view)

    newVC.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    newVC.didMove(toParent: self)

    currentChildVC = newVC
  }
}
