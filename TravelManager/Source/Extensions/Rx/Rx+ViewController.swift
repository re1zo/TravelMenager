import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {

    var viewWillAppear: ControlEvent<Bool> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }

    var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
}
