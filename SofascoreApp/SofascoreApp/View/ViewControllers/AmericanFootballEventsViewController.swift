//
//  AmericanFootballEventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit

final class AmericanFootballEventsViewController: UIViewController {
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No American Football Events"
        label.textAlignment = .center
        label.textColor = .gray
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
