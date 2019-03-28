//
//  NetworkProcessor.swift
//  OficExample
//
//  Created by LudMac on 28/03/19.
//  Copyright © 2019 LudMac. All rights reserved.
//

import Foundation

class NetworkProcessor
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(url:URL)
    {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func DownloadJSONFromUrl(_ completion: @escaping JSONDictionaryHandler) -> Void {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request){ (data, response, error) in
            if (error == nil)
            {
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        //Success
                        if let data = data{
                            //print(data)
                            
                            do{
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsonDictionary as? [String: Any])
                            }
                            catch let error as NSError{
                                print("errir \(error)")
                            }
                        }
                        
                    default:
                        print("default")
                    }
                }
            }
            else
            {
                print("Error: \(error?.localizedDescription)")
            }
        
        }
        
        dataTask.resume()
    }
}
