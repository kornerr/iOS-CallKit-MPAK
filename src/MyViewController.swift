import UIKit

class MyViewController: UIViewController {
  private let callButton = UIButton()
  private let incomingButton = UIButton()
  private let vcs = VideoCallSimulation()
  private let textField = UITextField()

  override func viewDidLoad() {
    super.viewDidLoad()

    let b = UIScreen.main.bounds

    // Статус видеозвонка.
    vcs.frame = CGRect(x: 0, y: 50, width: b.width, height: 200)
    view.addSubview(vcs)
    // Поле ввода номера.
    textField.frame = CGRect(x: 0, y: 300, width: b.width - 200, height: 50)
    textField.borderStyle = .roundedRect
    view.addSubview(textField)
    // Кнопка совершения звонка.
    callButton.frame = CGRect(x: b.width - 200, y: 300, width: 200, height: 50)
    callButton.setTitle("Начать видеозвонок", for: .normal)
    callButton.setTitleColor(.blue, for: .normal)
    callButton.addTarget(self, action: #selector(startVideoCall), for: .touchUpInside)
    view.addSubview(callButton)
    // Кнопка симуляции входящего звонка CallKit.
    incomingButton.frame = CGRect(x: 0, y: 400, width: b.width, height: 50)
    incomingButton.setTitle("Симулировать входящий видеозвонок через 2с", for: .normal)
    incomingButton.setTitleColor(.blue, for: .normal)
    incomingButton.addTarget(self, action: #selector(simulateIncomingCall), for: .touchUpInside)
    view.addSubview(incomingButton)
  }

  @objc func simulateIncomingCall(sender: UIButton) {
  }

  @objc func startVideoCall(sender: UIButton) {
  }
}
