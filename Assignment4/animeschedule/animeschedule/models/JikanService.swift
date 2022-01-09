//
//  JikanService.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import Foundation

class JikanService {
    
    static var shared = JikanService()
    
    func doSearch(input:String, handler: @escaping (SearchResults)->Void) {
        
        let fixedInput = input.replacingOccurrences(of: " ", with: "%20")
        
        let urlString = "https://api.jikan.moe/v3/search/anime?q="+fixedInput+"&page=1"
        
        let urlObj = URL(string: urlString)!
        
        let task =  URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            
            if let error = error {
                print(error)
                handler(SearchResults(results: [SearchResultInfo]()))
            }
            
            // check response code
            else if let jsonData = data {
                do{
                let decoder = JSONDecoder()
                    let result = try decoder.decode(SearchResults.self, from: jsonData)
                    
                    handler(result)
                    
                } catch {
                    print(error)
                    handler(SearchResults(results: [SearchResultInfo]()))
                }
            }
            
        }
        task.resume()
        
    }
    
    func getFavouriteSchedule(malId:Int32, handler:@escaping (ScheduleResults)->Void) {
        // get the schedule
        let urlString = "https://api.jikan.moe/v3/schedule"
        let urlObj = URL(string: urlString)!
        
        let task =  URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            
            if let error = error {
                print(error)
                handler(ScheduleResults(
                    monday: [ScheduleResultInfo](),
                    tuesday: [ScheduleResultInfo](),
                    wednesday: [ScheduleResultInfo](),
                    thursday: [ScheduleResultInfo](),
                    friday: [ScheduleResultInfo](),
                    saturday: [ScheduleResultInfo](),
                    sunday: [ScheduleResultInfo](),
                    other: [ScheduleResultInfo](),
                    unknown: [ScheduleResultInfo]()))
            }
            
            // check response code
            else if let jsonData = data {
                do{
                let decoder = JSONDecoder()
                    var result = try decoder.decode(ScheduleResults.self, from: jsonData)
                    
                    // find needed entry, remove the rest
                    result.monday = result.monday.filter{ $0.mal_id == malId }
                    result.tuesday = result.tuesday.filter{ $0.mal_id == malId }
                    result.wednesday = result.wednesday.filter{ $0.mal_id == malId }
                    result.thursday = result.thursday.filter{ $0.mal_id == malId }
                    result.friday = result.friday.filter{ $0.mal_id == malId }
                    result.saturday = result.saturday.filter{ $0.mal_id == malId }
                    result.sunday = result.sunday.filter{ $0.mal_id == malId }
                    result.other = result.other.filter{ $0.mal_id == malId }
                    result.unknown = result.unknown.filter{ $0.mal_id == malId }
                    
                    handler(result)
                    
                } catch {
                    print(error)
                    handler(ScheduleResults(
                        monday: [ScheduleResultInfo](),
                        tuesday: [ScheduleResultInfo](),
                        wednesday: [ScheduleResultInfo](),
                        thursday: [ScheduleResultInfo](),
                        friday: [ScheduleResultInfo](),
                        saturday: [ScheduleResultInfo](),
                        sunday: [ScheduleResultInfo](),
                        other: [ScheduleResultInfo](),
                        unknown: [ScheduleResultInfo]()))
                }
            }
            
        }
        task.resume()
        
    }
    
    
    
}
