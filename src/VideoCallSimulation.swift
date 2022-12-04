import UIKit

class VideoCallSimulation: UILabel {
  private(set) var callId: String? {
    didSet {
      refreshUI()
    }
  }

  private(set) var hasVideo = false {
    didSet {
      refreshUI()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .black
    numberOfLines = 0
    textAlignment = .center
    textColor = .white

    refreshUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { return nil }

  func startCall(
    callId: String,
    hasVideo: Bool
  ) {
    self.callId = callId
    self.hasVideo = hasVideo
  }

  private func refreshUI() {
    let callStatus = callId ?? "N/A"
    let videoStatus = hasVideo ? "Y" : "N"
    text = "VideoCallSimulation\ncall: '\(callStatus)'\nvideo: '\(videoStatus)'"
  }
}
