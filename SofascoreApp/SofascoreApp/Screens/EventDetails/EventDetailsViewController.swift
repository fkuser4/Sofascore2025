//
//  EventDetailsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import SnapKit
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
  private let navBar = NavigationBarView()
  private let titleView = EventDetailsTitleView()
  private let eventDetailsHeaderView = EventDetailsHeaderView()
  private let safeAreaView: UIView = .init()
  private var event: Event
  private var sport: SportType
  var onDismiss: (() -> Void)?

  private lazy var incidentsVC: IncidentsViewController = {
    let viewModel = IncidentsViewModel(eventId: event.id, sport: sport, league: event.league)
    return IncidentsViewController(viewModel: viewModel)
  }()

  init(viewModel: EventDetailsViewModel) {
    event = viewModel.event
    sport = viewModel.sport
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .contentBackground

    addViews()
    setupConstraints()
    styleViews()
    setupBindings()
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(navBar)
    view.addSubview(eventDetailsHeaderView)

    addChild(incidentsVC)
    view.addSubview(incidentsVC.view)
    incidentsVC.didMove(toParent: self)
  }

  func setupConstraints() {
    safeAreaView.snp.makeConstraints { make in
      make.top.equalTo(view)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
    }

    navBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
    }

    eventDetailsHeaderView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navBar.snp.bottom)
    }

    incidentsVC.view.snp.makeConstraints { make in
      make.top.equalTo(eventDetailsHeaderView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

  func styleViews() {
    let eventDetailsHeaderViewModel = EventDetailsHeaderViewModel(
      event: event
    )
    eventDetailsHeaderView.configure(with: eventDetailsHeaderViewModel)
    titleView.configure(league: event.league, sport: sport.title)

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

    eventDetailsHeaderView.onTeamTap = { [weak self] team in
      guard let self = self else { return }

      let teamDetailsViewModel = TeamDetailsViewModel(team: team)
      let teamDetailsVC = TeamDetailsViewController(viewModel: teamDetailsViewModel)
      teamDetailsVC.onDismiss = { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }

      self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
  }
}
