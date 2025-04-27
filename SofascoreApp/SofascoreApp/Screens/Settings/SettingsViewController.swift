//
//  SettingsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class SettingsViewController: UIViewController, BaseViewProtocol {
  private let navBar = NavigationBarView()
  private let safeAreaView: UIView = .init()
  private let titleLabel: UILabel = .init()
  private let settingsOverviewView: SettingsOverviewView = .init()
  private let settingsOverviewViewModel = SettingsOverviewViewModel()
  var onDismiss: (() -> Void)?


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    addViews()
    setupConstraints()
    styleViews()
    setupBindings()
    settingsOverviewViewModel.loadAll()
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(navBar)
    view.addSubview(settingsOverviewView)
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

    settingsOverviewView.snp.makeConstraints { make in
      make.top.equalTo(navBar.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview()
    }
  }

  func styleViews() {
    let config = NavigationBarConfiguration(
      title: "Settings",
      backIconColor: .backIconOnBlue,
      backgroundColor: .primaryBackgroundColor
    )
    navBar.configure(with: config)

    safeAreaView.backgroundColor = .primaryBackgroundColor
  }

  func setupBindings() {
    navBar.didTapBackButton = { [weak self] in
      self?.onDismiss?()
    }

    settingsOverviewViewModel.nameDidChange = { [weak settingsOverviewView] text in
      settingsOverviewView?.setName(text) }

    settingsOverviewViewModel.eventsDidChange = { [weak settingsOverviewView] text in
      settingsOverviewView?.setEventsCount(text)
    }

    settingsOverviewViewModel.leaguesDidChange = { [weak settingsOverviewView] text in
      settingsOverviewView?.setLeaguesCount(text)
    }

    settingsOverviewView.didTapLogout = {
      DataPersistenceManager.shared.deleteAllObjects { result in
        switch result {
        case .success:
          break
        case .failure(let error):
          print("Error deleting events: \(error)")
        }
      }
      UserDefaults.standard.set(nil, forKey: "name")
      AuthService.shared.logout()
      AppRouter.shared.showLogin(animated: true)
    }
  }
}
