//
//  Aux.swift
//  ZoomSwift
//
//  Created by ryan on 5/3/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import Foundation

func pretty_function(file:String = __FILE__, fnc:String = __FUNCTION__, line:(Int)=__LINE__) {
    let className = file.lastPathComponent.componentsSeparatedByString(".")
    println("\(className[0]):\(fnc):\(line)")
}

func pretty_function_string(file:String = __FILE__, fnc:String = __FUNCTION__, line:(Int)=__LINE__) -> String {
    let className = file.lastPathComponent.componentsSeparatedByString(".")
    return "\(className[0]):\(fnc):\(line)"
}