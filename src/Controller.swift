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
  }
}
