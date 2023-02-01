import Combine
import MPAK

class Controller: MPAK.Controller<Model> {
  init() {
    super.init(
      Model(),
      debugClassName: "Controller",
      debugLog: { print($0) }
    )
  }
}

extension Controller {
  func setupCall(_ myVC: MyViewController) {
    pipe(
      dbg: "makeUC",
      myVC.makeUICall.eraseToAnyPublisher(),
      { $0.isCallButtonPressed = true },
      { $0.isCallButtonPressed = false }
    )

    pipe(
      dbg: "makeVC",
      myVC.makeVoIPCall.eraseToAnyPublisher(),
      { $0.isCallKitOKButtonPressed = true },
      { $0.isCallKitOKButtonPressed = false }
    )

    pipeValue(
      dbg: "textCI",
      myVC.textCallId.eraseToAnyPublisher(),
      { $0.textCallId = $1 }
    )

    pipeValue(
      dbg: "voipCI",
      myVC.voipPushCallId.eraseToAnyPublisher(),
      { $0.voipCallId = $1 }
    )
  }
}
