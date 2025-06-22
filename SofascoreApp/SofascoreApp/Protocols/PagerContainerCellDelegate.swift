//
//  PagerContainerCellDelegate.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import Foundation

protocol PagerContainerCellDelegate: AnyObject {
  func pagerDidSwitchToPage(at index: Int)
  func pagerIsBeingSwiped(from fromIndex: Int, to toIndex: Int, progress: CGFloat)
  func pagerContentDidScroll(with offset: CGPoint)
}
