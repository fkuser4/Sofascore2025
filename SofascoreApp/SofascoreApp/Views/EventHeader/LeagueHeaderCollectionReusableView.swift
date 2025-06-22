//
//  LeagueHeaderCollectionReusableView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit

final class LeagueHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseIdentifier = "LeagueHeader"
  private let leagueHeaderView = LeagueHeaderView()

  var onTap: ((League) -> Void)?
  private var league: League?

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(leagueHeaderView)
    leagueHeaderView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
    setupTapGesture()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
    addGestureRecognizer(tapGesture)
    isUserInteractionEnabled = true
  }

  @objc private func headerTapped() {
    guard let league = league else { return }
    onTap?(league)
  }

  func configure(with viewModel: LeagueHeaderViewModel) {
    leagueHeaderView.configure(with: viewModel)
    self.league = viewModel.league
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    leagueHeaderView.configure(with: nil)
    league = nil
    onTap = nil
  }
}
