//
//  EventDetailsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class EventDetailsViewController: UIViewController, BaseViewProtocol {
  private let navBar = NavigationBarView()
  private let titleView = EventDetailsTitleView()
  private let eventDetailsView = EventDetailsHeaderView()
  private let safeAreaView: UIView = .init()
  var onDismiss: (() -> Void)?
  var event: Event?
  var sport: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .eventDetailsBackgroundColor

    addViews()
    setupConstraints()
    styleViews()
    setupBindings()
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(navBar)
    view.addSubview(eventDetailsView)
  }

  func setupConstraints() {
    safeAreaView.snp.makeConstraints {
      $0.top.equalTo(view)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
    }

    navBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
    }

    eventDetailsView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navBar.snp.bottom)
    }
  }

  func styleViews() {
    if let event = event {
      let eventDetailViewModel = EventDetailsHeaderViewModel(event: event)
      eventDetailsView.configure(with: eventDetailViewModel)
      titleView.configure(league: event.league, sport: sport ?? "")
    }

    let config = NavigationBarConfiguration(
      titleView: self.titleView,
      backIconColor: .backIconOnWhite,
      backgroundColor: .secondaryBackgroundColor
    )
    navBar.configure(with: config)

    safeAreaView.backgroundColor = .white
  }

  func setupBindings() {
    navBar.didTapBackButton = { [weak self] in
      self?.onDismiss?()
    }
  }
}
