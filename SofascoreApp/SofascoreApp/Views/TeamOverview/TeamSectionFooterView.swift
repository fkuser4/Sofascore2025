//
//  TeamSectionFooterView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class TeamSectionFooterView: UICollectionReusableView {
  static let reuseIdentifier = "TeamSectionFooterView"

  private let line = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    line.backgroundColor = .secondary
    addSubview(line)
    line.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(7)
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(lineIsVisible: Bool = true) {
    line.isHidden = !lineIsVisible
  }
}
