//
//  Connectivity.swift
//  ParthCoreDataPractice
//
//  Created by ravi on 27/04/18.
//  Copyright © 2018 ravi. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

