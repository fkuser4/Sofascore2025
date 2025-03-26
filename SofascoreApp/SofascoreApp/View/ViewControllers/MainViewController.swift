//
//  ViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 09.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class MainViewController: UIViewController {
  private var leagues: [League] = []
  private var eventsMap: [String: [Event]] = [:]

  private var homeworkDataSource = Homework2DataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    getLeagues()
    getEvents()
    setupUI()
  }

  private func setupUI() {
    for league in leagues {
      let leagueHeaderViewModel = LeagueHeaderViewModel(league: league)

      let leagueHeaderView = LeagueHeaderView()
      leagueHeaderView.configure(with: leagueHeaderViewModel)

      view.addSubview(leagueHeaderView)

      leagueHeaderView.snp.makeConstraints {
        $0.leading.trailing.equalTo(view)
        $0.top.equalTo(view.safeAreaLayoutGuide)
        $0.height.equalTo(56)
      }

      let eventsStackView = UIStackView()
      eventsStackView.axis = .vertical
      eventsStackView.alignment = .fill
      eventsStackView.distribution = .fillEqually

      view.addSubview(eventsStackView)

      if var events = eventsMap[league.name] {
        events.sort { $0.startTimestamp < $1.startTimestamp }

        for event in events {
          let eventViewModel = EventViewModel(event: event)
          let eventView = EventView()
          eventView.configure(with: eventViewModel)
          eventsStackView.addArrangedSubview(eventView)
        }

        eventsStackView.snp.makeConstraints {
          $0.top.equalTo(leagueHeaderView.snp.bottom)
          $0.leading.trailing.equalTo(view)
          $0.height.equalTo(56 * events.count)
        }
      }
    }
  }

  private func getLeagues() {
    let laLiga = homeworkDataSource.laLigaLeague()

    leagues.append(laLiga)
  }

  private func getEvents() {
    let laLigaEvents = homeworkDataSource.laLigaEvents()

    eventsMap["La Liga"] = laLigaEvents
  }
}
