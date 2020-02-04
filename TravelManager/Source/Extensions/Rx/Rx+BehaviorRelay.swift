import RxRelay

extension BehaviorRelay where Element: RangeReplaceableCollection {

    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
}
