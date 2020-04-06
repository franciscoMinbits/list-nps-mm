//
//  ServiceImp.swift
//  nps
//
//  Created by Ascenzo on 01/04/20.
//  Copyright © 2020 kinedu. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON
import RealmSwift

class ServiceImpl: ServiceProtocol {
 
  init() {
  }
  struct ErrorHttpCode {
    static var OkCode = 200
    static var Invalid = 404
    static var Other = 409
    static var unauthorized = 401
  }
  
  struct ParseType {
    static var loadNPSType = 1
  }
  
  func loadNPS(completion: @escaping (ServiceResponse) -> Void) {
    AF.request(Router.loadNPS).responseJSON { response in
      self.parseResponse(response: response,parseType: ParseType.loadNPSType, completion: completion)
    }
  }
  
  
  func parseResponse(response : AFDataResponse<Any> , parseType: Int , completion: @escaping (ServiceResponse) -> Void)  {
    switch response.result {
    case .success(let value):
      guard let urlResponse = response.response else {
        completion(.failure)
        return
      }
      switch urlResponse.statusCode {
      case ErrorHttpCode.OkCode:
        if let json = value as? [NSDictionary] {
          switch parseType {
          case ParseType.loadNPSType:
            if let data = ParseUtils.parseNPSData(data: json) {
              completion(.successLoadNPS(data: data))
            } else {
              completion(.failure)
            }
            break
          default:
            completion(.failure)
            break
          }
        }
        break
      case ErrorHttpCode.Invalid, ErrorHttpCode.Other  :
        completion(.failure)
        break
      case NSURLErrorTimedOut:
        completion(.timeOut)
      case NSURLErrorNotConnectedToInternet:
        completion(.notConnectedToInternet)
      case ErrorHttpCode.unauthorized:
        completion(.unauthorized)
      default:
        completion(.failure)
      }
      
    case .failure(let error):
      if let error = error as NSError?{
        print("Response Error Code \(error.code)")
        switch error.code {
        case NSURLErrorNotConnectedToInternet:
          completion(.notConnectedToInternet)
          break
        case NSURLErrorTimedOut:
          completion(.timeOut)
        case NSURLErrorUserAuthenticationRequired:
          completion(.unauthorized)
        case ErrorHttpCode.Other:
          completion(.failure)
        default:
          completion(.failure)
        }
      } else {
        completion(.failure)
      }
    }
  }
}
