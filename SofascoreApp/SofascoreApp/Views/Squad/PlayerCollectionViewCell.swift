//
//  PlayerCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class PlayerCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "PlayerCollectionViewCell"
  private let playerView = PlayerView()
  private let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .secondary
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(playerView)
    contentView.addSubview(separatorView)

    playerView.snp.makeConstraints { $0.edges.equalToSuperview() }

    separatorView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }

    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: PlayerViewModel?, isLast: Bool = false) {
    playerView.configure(with: viewModel)
    separatorView.isHidden = isLast
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    playerView.configure(with: nil)
    separatorView.isHidden = false
  }
}
