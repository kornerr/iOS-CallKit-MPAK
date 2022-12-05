import CallKit

/**/import UIKit

class IncomingCallSimulation: NSObject {
  private var provider: CXProvider?

  override init() {
    super.init()

    let cfg = CXProviderConfiguration()
    cfg.supportedHandleTypes = [.generic]
    cfg.supportsVideo = true

    provider = CXProvider(configuration: cfg)
    provider?.setDelegate(self, queue: DispatchQueue.main)
  }

  func startCall(hasVideo: Bool) {
    let upd = CXCallUpdate()
    upd.remoteHandle = CXHandle(type: .generic, value: "Wake up, Neo")
    upd.hasVideo = hasVideo

    provider?.reportNewIncomingCall(with: UUID(), update: upd) { err in
      /**/print("IncomingCS.startC err: '\(String(describing: err))'")
    }
  }
}

extension IncomingCallSimulation: CXProviderDelegate {
  func providerDidReset(_: CXProvider) {
    /**/print("IncomingCS.providerDR")
  }

  func provider(_: CXProvider, perform action: CXAnswerCallAction) {
    action.fulfill()
    //accept.send()
    /**/print("App.providerPAA")
  }

  func provider(_: CXProvider, perform action: CXEndCallAction) {
    action.fulfill()
    /**/print("App.providerPAE")
  }
}
