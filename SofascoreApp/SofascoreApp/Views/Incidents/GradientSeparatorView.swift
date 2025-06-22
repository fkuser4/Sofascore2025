//
//  GradientSeparator.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit

class GradientSeparatorView: UIView {
  private let gradientLayer = CAGradientLayer()

  public init() {
    super.init(frame: .zero)

    layer.addSublayer(gradientLayer)

    gradientLayer.colors = [
      UIColor.systemGray5.cgColor,
      UIColor.contentBackground.cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
