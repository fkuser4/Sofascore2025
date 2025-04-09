//
//  SectionDividerView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit

final class SectionDividerView: UICollectionReusableView {
  static let reuseIdentifier = "SectionDivider"
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
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
