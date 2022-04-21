import SwiftUI

extension ViewAttribute {
    
    public var scrollAxis: Axis.Set? {
        guard let stringValue = item.value as? String else {
            return nil
        }
        
        return stringValue == "horizontal" ? .horizontal : .vertical
    }
}
