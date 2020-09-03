//
//  PictureApiRequest.swift
//  pictureApi
//
//  Created by Rukhsar on 28/08/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import Foundation
import Alamofire

struct PictureApiRequest {
    let pictureApiUrl = "https://jsonplaceholder.typicode.com/photos"
    
    func performRequest(completion: @escaping(Result<[PictureApi]>)-> Void){
        Alamofire.request("https://jsonplaceholder.typicode.com/photos").response{ response in
            if let safeData = response.data{
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([PictureApi].self, from: safeData)
                completion(.success(decodedData))
                // print(decodedData[0].url)
            }catch{
                completion(.failure(error))
            }
            }
        }
        
        
    }
}



/// URL Session Method

//func performRequest(completion: @escaping(Result<[PictureApi] , pictureError>)-> Void){
//
//      if let url = URL(string: pictureApiUrl){
//          let session = URLSession(configuration: .default)
//          let task = session.dataTask(with: url) { (data, response, error) in
//              if let safeData = data{
//                  let decoder = JSONDecoder()
//                  do {
//                      let decodedData = try decoder.decode([PictureApi].self, from: safeData)
//                      completion(.success(decodedData))
//                     // print(decodedData[0].url)
//                  }catch{
//                      completion(.failure(.cannotProcessData))
//                  }
//              }
//          }
//          task.resume()
//      }
//
//  }
