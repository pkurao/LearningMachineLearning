//
//  DataParser.swift
//  LearningMachineLearning
//
//  Created by Grace on 7/20/15.
//

import Foundation

enum IrisType: String {
    case Setosa = "Iris-setosa"
    case Versicolor = "Iris-versicolor"
    case Virginica = "Iris-virginica"
}

extension IrisType {
    func type() -> DataType {
        switch self {
        case .Setosa:
            return .Type0
        case .Versicolor:
            return .Type1
        case .Virginica:
            return .Type2
        }
    }
}

class IrisData {
    var data = [[Double]]()
    var labels = [IrisType]()
    var attributes = [String]()
    
    init() {
        if let text = textFromBundle("iris")?.componentsSeparatedByString("\n") {
            parseIrisData(text)
            parseAttributes(text)
        }
    }
    
    func parseIrisData(text: [String]) {
        var active = false
        for string in text {
            if active {
                let vals = string.componentsSeparatedByString(",")
                if vals.count < 5 {
                    break
                }
                let nums = Array(vals[0..<4]).map {
                    //Double($0)
                    ($0 as NSString).doubleValue
                }
                data.append(nums)
                labels.append(IrisType(rawValue: vals[4])!)
            }
            if string.hasPrefix("@DATA") {
                active = true
            }
        }
    }
    
    func parseAttributes(text: [String]) {
        for string in text {
            if string.hasPrefix("@ATTRIBUTE") {
                let attr = string.componentsSeparatedByString("\t")
                let attr2 = attr[0].componentsSeparatedByString(" ")
                attributes.append(attr2[1])
            }
            else if string.hasPrefix("@DATA") {
                break
            }
        }
    }
}
