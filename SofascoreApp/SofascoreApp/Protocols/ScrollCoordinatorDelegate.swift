//
//  ScrollCoordinatorDelegate.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import Foundation

protocol ScrollCoordinatorDelegate: AnyObject {
  func scrollCoordinatorDidRequestNavBarUpdate(for yOffset: CGFloat)
  func scrollCoordinatorDidRequestTabBarUpdate(from fromIndex: Int, to toIndex: Int, progress: CGFloat)
  func scrollCoordinatorDidRequestMainScrollUpdate(to yOffset: CGFloat)
}
