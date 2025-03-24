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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leagueHeaderView)
        leagueHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LeagueHeaderViewModel) {
        leagueHeaderView.configure(with: viewModel)
    }
}
