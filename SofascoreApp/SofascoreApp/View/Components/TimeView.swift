//
//  TimeView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.03.2025..
//

import SofaAcademic
import UIKit
import SnapKit

class TimeView: BaseView {
    
    private let statusLabel = UILabel()
    private let timeLabel = UILabel()
    
    func configure(matchTime: String, statusText: String, statusTextColor: UIColor) {
            timeLabel.text = matchTime
            timeLabel.textColor = Colors.textSecondary
            
            statusLabel.text = statusText
            statusLabel.textColor = statusTextColor
    }
    
    override func addViews() {
        addSubview(statusLabel)
        addSubview(timeLabel)
    }

    override func styleViews() {
        statusLabel.font = Fonts.regular(size: 12)
        timeLabel.font = Fonts.regular(size: 12)
    }

    override func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-6)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(-6)
            make.width.lessThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    override func setupGestureRecognizers() {
            // Configure gesture recognizers
    }

    override func setupBinding() {
            // Set up bindings
    }
}
