//
//  BasketballEventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit

final class BasketballEventsViewController: UIViewController {
  private lazy var emptyLabel: UILabel = {
    let label = UILabel()
    label.text = "No Basketball Events"
    label.textAlignment = .center
    label.textColor = .secondary
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(emptyLabel)
    emptyLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
