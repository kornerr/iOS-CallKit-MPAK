import Combine
import MPAK

class Controller: MPAK.Controller<Model> {
  init() {
    super.init(Model())
  }
}

extension Controller {
  func setupCall(_ myVC: MyViewController) {
    pipe(
      myVC.makeUICall.eraseToAnyPublisher(),
      { $0.isCallButtonPressed = true },
      { $0.isCallButtonPressed = false }
    )

    pipe(
      myVC.makeVoIPCall.eraseToAnyPublisher(),
      { $0.isCallKitOKButtonPressed = true },
      { $0.isCallKitOKButtonPressed = false }
    )

    pipeValue(
      myVC.textCallId.eraseToAnyPublisher(),
      { $0.textCallId = $1 }
    )

    pipeValue(
      myVC.voipPushCallId.eraseToAnyPublisher(),
      { $0.voipCallId = $1 }
    )
  }
}
