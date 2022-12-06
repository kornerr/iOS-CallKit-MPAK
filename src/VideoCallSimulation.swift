import UIKit

class VideoCallSimulation: UILabel {
  private(set) var callId: String? {
    didSet {
      refreshUI()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .black
    textColor = .white
    refreshUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { return nil }

  func startCall(callId: String) {
    self.callId = callId
  }

  private func refreshUI() {
    let callStatus = callId ?? "N/A"
    text = "VideoCallSimulation: '\(callStatus)'"
  }
}
