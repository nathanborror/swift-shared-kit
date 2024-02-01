#if os(iOS)
import UIKit

public class ClosureButton: UIButton {
    private var action: (() -> Void)?

    public func addAction(for event: UIControl.Event = .touchUpInside, action: @escaping () -> Void) {
        self.action = action
        addTarget(self, action: #selector(triggerAction), for: event)
    }

    @objc private func triggerAction() {
        action?()
    }
}
#endif
