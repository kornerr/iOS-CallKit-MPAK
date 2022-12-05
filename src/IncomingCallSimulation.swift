import CallKit

/**/import UIKit

class IncomingCallSimulation: NSObject {
  private var provider: CXProvider?

  override init() {
    super.init()

    let cfg = CXProviderConfiguration()
    cfg.maximumCallGroups = 1
    cfg.maximumCallsPerCallGroup = 1
    cfg.supportedHandleTypes = [.generic]
    cfg.supportsVideo = true

    provider = CXProvider(configuration: cfg)
    provider?.setDelegate(self, queue: DispatchQueue.main)
    /**/print("IncomingCS.init")
  }

  func startCall(
    callId: String,
    hasVideo: Bool
  ) {
    let upd = CXCallUpdate()
    upd.localizedCallerName = callId
    upd.remoteHandle = CXHandle(type: .generic, value: "call-id")
    upd.hasVideo = hasVideo
    upd.supportsHolding = false
    upd.supportsGrouping = false
    upd.supportsUngrouping = false
    upd.supportsDTMF = false

    provider?.reportNewIncomingCall(with: UUID(), update: upd) { err in
      /**/print("IncomingCS.startC-2 err: '\(String(describing: err))'")
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
