//
//  Operations.swift
//  Calculator
//
//  Created by Henry Rogers on 1/3/20.
//  Copyright © 2020 Henry Rogers. All rights reserved.
//

import Foundation

struct Operations{
    static func operate(_ n1: Double, _ n2: Double, opporation opp: Double) ->Double{
        switch opp {
        case 1:
            return n1 + n2
        case 2:
            return n1 - n2
        case 3:
            return n1 * n2
        case 4:
            return n1 / n2
        default:
            return n1
        }
    }
    
    
}
