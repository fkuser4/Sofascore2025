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
  private let mainViewModel = MainViewModel()

  private let containerView = UIView()
  private lazy var eventsVC: EventsViewController = {
    let viewModel = mainViewModel.eventsViewModel(for: .football)! // swiftlint:disable:this force_unwrapping
    return EventsViewController(viewModel: viewModel)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    addViews()
    setupConstraints()
    setupBindings()
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
    sportSelectorView.configure(with: SportType.allCases)

    sportSelectorView.onTap = { [weak self] sport in
      guard let self = self else { return }
      guard let selectedViewModel = self.mainViewModel.eventsViewModel(for: sport) else { return }
      self.eventsVC.viewModel = selectedViewModel
    }
  }
}
