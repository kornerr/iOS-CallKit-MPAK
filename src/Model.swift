struct Model {
  var isCallButtonPressed = false
  var isCallKitOKButtonPressed = false
  var textCallId: String?
  var voipCallId: String?
}

extension Model {
  // Следует начать звонок, если:
  // 1. нажали на кнопку «Начать звонок» при наличии номера звонка
  // 2. нажали на кнопку «✅» в CallKit при наличии номера звонка из пуша
  var shouldMakeCall: String? {
    if
      isCallButtonPressed,
      let id = textCallId
    {
      return id
    }

    if
      isCallKitOKButtonPressed,
      let id = voipCallId
    {
      return id
    }

    return nil
  }
}
