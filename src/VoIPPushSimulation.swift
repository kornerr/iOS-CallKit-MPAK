import UIKit

protocol VoIPPushSimulationDelegate {
  func voipPushSimulationDidReceivePayload(_ payload: String)
}

class VoIPPushSimulation {
  var delegate: VoIPPushSimulationDelegate?

  func simulate(payload: String, after delay: DispatchTimeInterval) {
    let bgId = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
    // Прямо с Kodeco такой ужасный пример обращения к UIApplication:
    // https://www.kodeco.com/1276414-callkit-tutorial-for-ios
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
      self?.delegate?.voipPushSimulationDidReceivePayload(payload)
      UIApplication.shared.endBackgroundTask(bgId)
    }
  }
}
