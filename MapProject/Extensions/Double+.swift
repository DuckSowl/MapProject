//
//  Double+.swift
//  MapProject
//
//  Created by Anton Tolstov on 07.09.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

extension Double {
        
    func add(_ other: Double) -> Double {
        self + other
    }
    
    func subtract(_ other: Double) -> Double {
        self - other
    }    
    
    func modulus(_ module: Double) -> Double {
        let twiceModule = module * 2
        return self.add(module)
            .truncatingRemainder(dividingBy: twiceModule)
            .add(twiceModule)
            .truncatingRemainder(dividingBy: twiceModule)
            .subtract(module)
    }
}
