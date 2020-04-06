//
//  ParseUtils.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class ParseUtils {
    
    static func parseNPSData(data: [NSDictionary]) ->[NPSData]?{
        let json = JSON(data)
        if let lstResponse = json.rawString() {
            //print("JSON: \(lstResponse)")
            if  let searchData = Mapper<NPSData>().mapArray(JSONString: lstResponse) {
                return searchData
            }
        }
        return nil
    }
}
