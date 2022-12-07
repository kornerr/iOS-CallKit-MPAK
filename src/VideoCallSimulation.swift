import UIKit

class VideoCallSimulation: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .black
    textColor = .white
    refreshUI(nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { return nil }

  func startCall(callId: String) {
    refreshUI(callId)
  }

  private func refreshUI(_ callId: String?) {
    let status = callId ?? "N/A"
    text = "VideoCallSimulation status: '\(status)'"
  }
}
