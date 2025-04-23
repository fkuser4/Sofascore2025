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
  var onDismiss: (() -> Void)?
  private let titleLabel: UILabel = .init()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    addViews()
    setupConstraints()
    styleViews()
    setupBindings()
  }

  func addViews() {
    view.addSubview(safeAreaView)
    view.addSubview(navBar)
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
  }
}
