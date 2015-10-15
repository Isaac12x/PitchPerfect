//
//  RecordedAudio.swift
//  Pitch Perfec v2
//
//  Created by Isaac Albets Ramonet on 25/7/15.
//  Copyright (c) 2015 Isaac Albets Ramonet. All rights reserved.
//

import Foundation


// Since RecordedAudio is a root class (it is not subclassing from any other class) we don't need to call a super initializer.

class RecordedAudio {
    
    var filePathUrl: NSURL!
    var title: String!
    
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}