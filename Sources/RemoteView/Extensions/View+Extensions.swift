import SwiftUI

extension View {
    
    @ViewBuilder
    func unwrapAndApply<Item, Content: View>(_ item: Item?, @ViewBuilder apply: (Item, Self) -> Content) -> some View {
        if item != nil {
            apply(item!, self)
        } else {
            self
        }
    }
}
