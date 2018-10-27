
import Foundation

protocol Router: class {
    var view: Navigatable? {get set}
}

extension Router {
    
    func attachView(view: Navigatable) {
        self.view = view
    }
}
