//
//  CircularProgressView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit

final class CircularProgressView: UIView {
  private let backgroundLayer = CAShapeLayer()
  private let progressLayer = CAShapeLayer()
  private var currentProgress: CGFloat = 0

  private let lineWidth: CGFloat = 6
  private let animationDuration: TimeInterval = 1.0

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayers()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayers()
  }

  private func setupLayers() {
    backgroundColor = .clear

    backgroundLayer.fillColor = UIColor.clear.cgColor
    backgroundLayer.strokeColor = UIColor.teamPostionBackground.cgColor
    backgroundLayer.lineWidth = lineWidth
    backgroundLayer.lineCap = .butt
    layer.addSublayer(backgroundLayer)

    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = UIColor.primaryBackgroundColor.cgColor
    progressLayer.lineWidth = lineWidth
    progressLayer.lineCap = .butt
    progressLayer.strokeEnd = 0
    layer.addSublayer(progressLayer)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    updateLayers()
  }

  private func updateLayers() {
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2

    let circularPath = UIBezierPath(
      arcCenter: center,
      radius: radius,
      startAngle: -CGFloat.pi / 2,
      endAngle: 3 * CGFloat.pi / 2,
      clockwise: true
    )

    backgroundLayer.path = circularPath.cgPath
    progressLayer.path = circularPath.cgPath
  }

  func setProgress(numerator: CGFloat, denominator: CGFloat, animated: Bool = true) {
    guard denominator > 0 else { return }
    let progress = min(numerator / denominator, 1.0)
    setProgress(progress, animated: animated)
  }

  func setProgress(_ progress: CGFloat, animated: Bool = true) {
    let clampedProgress = max(0, min(1, progress))

    if animated {
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = currentProgress
      animation.toValue = clampedProgress
      animation.duration = animationDuration
      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      animation.fillMode = .forwards
      animation.isRemovedOnCompletion = false

      progressLayer.add(animation, forKey: "progressAnimation")
    } else {
      progressLayer.strokeEnd = clampedProgress
    }

    currentProgress = clampedProgress
  }

  func resetProgress(animated: Bool = true) {
    setProgress(0, animated: animated)
  }
}
