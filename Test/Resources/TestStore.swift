//
//  TestStore.swift
//  Test
//
//  Created by Miguel Vicario on 29/07/20.
//  Copyright © 2020 Miguel Vicario. All rights reserved.
//

import UIKit

public class TestStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 20.0
        return URLSession(configuration: config)
    }()
    
    public func serviceCall(url: URL, completion: @escaping (UIImage) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            if error == nil {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                if statusCode == 200{
                    completion(UIImage(data: data!)!)
                }
            }
        }
        
        task.resume()
    }
}
