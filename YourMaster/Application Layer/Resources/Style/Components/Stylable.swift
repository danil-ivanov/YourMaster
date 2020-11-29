
import Foundation

protocol Stylable { }

extension NSObject: Stylable { }

extension Stylable {
    
    static func style(style: @escaping Style<Self>) -> Style<Self> { return style }
    
    func apply(_ style: StyleWrapper<Self>...) {
        style.forEach {
            switch $0 {
            case let .wrap(style):
                style(self)
            }
        }
    }
}
