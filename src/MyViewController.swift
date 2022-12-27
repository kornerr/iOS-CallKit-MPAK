import CallKit
import Combine
import UIKit

class MyViewController: UIViewController, VoIPPushSimulationDelegate, CXProviderDelegate {
  private let callButton = UIButton()
  private let incomingButton = UIButton()
  private let makeUICall = PassthroughSubject<String, Never>()
  private let makeVoIPCall = PassthroughSubject<Void, Never>()
  private let vcs = VideoCallSimulation()
  private let vps = VoIPPushSimulation()
  private var provider: CXProvider?
  private let textField = UITextField()
  private var subscriptions = [AnyCancellable]()
  private var voipPushCallId = PassthroughSubject<String, Never>()

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
    callButton.setTitle("Начать звонок", for: .normal)
    callButton.setTitleColor(.blue, for: .normal)
    callButton.addTarget(self, action: #selector(simulateOutgoingCall), for: .touchUpInside)
    view.addSubview(callButton)

    // Кнопка симуляции входящего звонка CallKit.
    incomingButton.frame = CGRect(x: 0, y: 400, width: b.width, height: 50)
    incomingButton.setTitle("Симулировать входящий звонок", for: .normal)
    incomingButton.setTitleColor(.blue, for: .normal)
    incomingButton.addTarget(self, action: #selector(simulateIncomingCall), for: .touchUpInside)
    view.addSubview(incomingButton)

    // Настраиваем CallKit.
    let cfg = CXProviderConfiguration()
    cfg.supportedHandleTypes = [.generic]
    provider = CXProvider(configuration: cfg)
    provider?.setDelegate(self, queue: DispatchQueue.main)

    // Настраиваем получение пушей VoIP.
    vps.delegate = self

    // Совершаем звонок разными способами:
    // 1. из UI после нажатия на кнопку «Начать звонок»
    // 2. в ответ на VoIP push после нажатия на кнопку «✅» в CallKit
    Publishers.Merge(
      makeUICall,
      Publishers.CombineLatest(
        voipPushCallId,
        makeVoIPCall
      )
        .map { $0.0 }
    )
      .sink { [weak self] id in self?.vcs.startCall(callId: id) }
      .store(in: &subscriptions)
  }

  @objc func simulateIncomingCall(sender: UIButton) {
    vps.simulate(payload: UUID().uuidString, after: .seconds(3))
  }

  @objc func simulateOutgoingCall(sender: UIButton) {
    guard let id = textField.text else { return }
    makeUICall.send(id)
  }

  func voipPushSimulationDidReceivePayload(_ payload: String) {
    guard let id = UUID(uuidString: payload) else { return }
    voipPushCallId.send(id)
    let upd = CXCallUpdate()
    upd.remoteHandle = CXHandle(type: .generic, value: "Wake up, Neo")
    provider?.reportNewIncomingCall(with: id, update: upd) { _ in }
  }

  func providerDidReset(_: CXProvider) { }

  func provider(_: CXProvider, perform action: CXAnswerCallAction) {
    action.fulfill()
    makeVoIPCall.send()
  }
}
