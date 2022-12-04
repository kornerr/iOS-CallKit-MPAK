import UIKit

class VideoCallSimulation: UILabel {
  var callId: String? {
    didSet {
      refreshUI()
    }
  }

  var hasVideo = false {
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

  private func refreshUI() {
    let callStatus = callId ?? "N/A"
    let videoStatus = hasVideo ? "Y" : "N"
    text = "VideoCallSimulation\ncall: '\(callStatus)'\nvideo: '\(videoStatus)'"
  }
}
