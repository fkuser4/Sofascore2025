//
//  EventStatus.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 12.04.2025..
//
public enum EventStatus: String, Decodable {
  case finished = "FINISHED"
  case notStarted = "NOT_STARTED"
  case halftime = "HALF_TIME"
  case inProgress = "IN_PROGRESS"
}
