import SwiftUI

extension CGFloat {
    
    init?(_ doubleValue: Double?) {
        guard let doubleValue = doubleValue else {
            return nil
        }

        self = doubleValue
    }
    
    init?(_ floatValue: Float?) {
        guard let floatValue = floatValue else {
            return nil
        }

        self = CGFloat.init(floatValue)
    }
}
