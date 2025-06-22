//
//  TeamSectionHeaderViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
struct TeamSectionHeaderViewModel {
  let sectionType: TeamOverviewSectionType

  var title: String {
    return sectionType.title ?? ""
  }

  var shouldShow: Bool {
    return sectionType.hasHeader
  }
}
