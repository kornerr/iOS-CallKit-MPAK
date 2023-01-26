struct Model {
  var textCallId: String?
  var voipCallId: String?
  var isCallButtonPressed = false
  var isCallKitOKButtonPressed = false
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
