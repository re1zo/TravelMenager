extension String {

    func localized(_ instance: Localization = Localization.default) -> String {
        instance.string(forPath: self) ?? self
    }

    func localized(_ instance: Localization = Localization.default, parameters: String...) -> String {
        (instance.string(forPath: self) ?? self).parametrized(parameters)
    }

    private func parametrized(_ parameters: [String]) -> String {
        var result = self
        parameters.enumerated().forEach { result = result.replacingOccurrences(of: "{\($0.offset)}", with: $0.element) }
        return result
    }
}
