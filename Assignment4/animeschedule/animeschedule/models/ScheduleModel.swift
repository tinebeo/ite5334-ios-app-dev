//
//  ScheduleModel.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-30.
//

import Foundation

struct ScheduleResults : Codable {
    public var monday : [ScheduleResultInfo]
    public var tuesday : [ScheduleResultInfo]
    public var wednesday : [ScheduleResultInfo]
    public var thursday : [ScheduleResultInfo]
    public var friday : [ScheduleResultInfo]
    public var saturday : [ScheduleResultInfo]
    public var sunday : [ScheduleResultInfo]
    public var other : [ScheduleResultInfo]
    public var unknown : [ScheduleResultInfo]
}

struct ScheduleResultInfo : Codable {
    var mal_id : Int
    var image_url : String
    var title : String
}
