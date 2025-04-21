//
//  EventCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit

final class EventCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "EventCell"
  private let eventView = EventView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(eventView)
    eventView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: EventViewModel) {
    eventView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    eventView.configure(with: nil)
  }

  override var isSelected: Bool {
    didSet {
      if super.isSelected {
        UIView.animate(withDuration: 0.1, animations: {
          self.backgroundColor = .systemGray5
        }, completion: { _ in
          self.backgroundColor = .white
        })
      }
    }
  }
}
