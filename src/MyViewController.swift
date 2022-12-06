import CallKit
import UIKit

class MyViewController: UIViewController, VoIPPushSimulationDelegate, CXProviderDelegate {
  private let callButton = UIButton()
  private let incomingButton = UIButton()
  private let vcs = VideoCallSimulation()
  private let vps = VoIPPushSimulation()
  private let textField = UITextField()
  private var provider: CXProvider?

  override func viewDidLoad() {
    super.viewDidLoad()

    let b = UIScreen.main.bounds

    // Статус видеозвонка.
    vcs.frame = CGRect(x: 0, y: 50, width: b.width, height: 200)
    view.addSubview(vcs)
    // Поле ввода номера.
    textField.frame = CGRect(x: 0, y: 300, width: b.width, height: 50)
    textField.borderStyle = .roundedRect
    view.addSubview(textField)
    // Кнопка совершения звонка.
    callButton.frame = CGRect(x: 0, y: 350, width: b.width, height: 50)
    callButton.setTitle("Начать видеозвонок", for: .normal)
    callButton.setTitleColor(.blue, for: .normal)
    callButton.addTarget(self, action: #selector(simulateOutgoingCall), for: .touchUpInside)
    view.addSubview(callButton)
    // Кнопка симуляции входящего звонка CallKit.
    incomingButton.frame = CGRect(x: 0, y: 400, width: b.width, height: 50)
    incomingButton.setTitle("Симулировать входящий видеозвонок", for: .normal)
    incomingButton.setTitleColor(.blue, for: .normal)
    incomingButton.addTarget(self, action: #selector(simulateIncomingCall), for: .touchUpInside)
    view.addSubview(incomingButton)

    // Настраиваем CallKit.
    let cfg = CXProviderConfiguration()
    cfg.supportedHandleTypes = [.generic]
    cfg.supportsVideo = true
    provider = CXProvider(configuration: cfg)
    provider?.setDelegate(self, queue: DispatchQueue.main)
    // Получаем пуши VoIP.
    vps.delegate = self
  }

  @objc func simulateIncomingCall(sender: UIButton) {
    vps.simulate(payload: UUID().uuidString, after: .seconds(3))
  }

  @objc func simulateOutgoingCall(sender: UIButton) {
    guard let id = textField.text else { return }
    vcs.startCall(callId: id, hasVideo: true)
  }

  func voipPushSimulationDidReceivePayload(_ payload: String) {
    guard let id = UUID(uuidString: payload) else { return }
    let upd = CXCallUpdate()
    upd.remoteHandle = CXHandle(type: .generic, value: "Wake up, Neo")
    upd.hasVideo = false
    provider?.reportNewIncomingCall(with: id, update: upd) { err in
      /**/print("MyVC.voipPSDRP err: '\(String(describing: err))'")
    }
  }

  func providerDidReset(_: CXProvider) {
    /**/print("MyVC.providerDR")
  }

  func provider(_: CXProvider, perform action: CXAnswerCallAction) {
    action.fulfill()
    //accept.send()
    /**/print("MyVC.providerPAA")
  }

  func provider(_: CXProvider, perform action: CXEndCallAction) {
    action.fulfill()
    /**/print("MyVC.providerPAE")
  }
}
