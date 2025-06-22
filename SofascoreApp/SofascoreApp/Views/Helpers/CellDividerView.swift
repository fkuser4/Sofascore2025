//
//  CellDividerView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SofaAcademic

class CellDividerView: BaseView {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 1, height: UIView.noIntrinsicMetric)
  }

  override func styleViews() {
    self.backgroundColor = .secondary
  }
}
