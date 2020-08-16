//
//  UserTrackingModeButton.swift
//  MapProject
//
//  Created by Anton Tolstov on 16.08.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Mapbox

class UserTrackingModeButton: UIButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 4
        static let backgroundColor = UIColor.systemGray6.withAlphaComponent(0.97)
    }
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = Constants.backgroundColor
        self.layer.cornerRadius = Constants.cornerRadius
        
        update(with: MGLUserTrackingMode.none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(with mode: MGLUserTrackingMode?) {
        var postfix: String
        
        if let mode = mode {
            switch mode {
                case .none:              postfix = ""
                case .follow:            postfix = ".fill"
                case .followWithCourse:  postfix = ".north.fill"
                case .followWithHeading: postfix = ".north.line.fill"
                @unknown default: fatalError("Unknown user tracking mode")
            }
        } else {
            postfix = ".slash"
        }
        
        setImage(UIImage(systemName: "location\(postfix)"), for: .normal)
    }
}
