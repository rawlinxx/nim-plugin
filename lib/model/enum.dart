/// EventType
/// 
enum EventType {
  unknown,
  didAddRecentSession,
  didUpdateRecentSession,
  didRemoveRecentSession,
  didReceiveRemoteNotification
}
extension EventTypeExt on EventType {
  static EventType create(String rawValue) {
      switch (rawValue) {
        case "didAddRecentSession":
          return EventType.didAddRecentSession;
        case "didUpdateRecentSession":
          return EventType.didUpdateRecentSession;
        case "didRemoveRecentSession":
          return EventType.didRemoveRecentSession;
        case "didReceiveRemoteNotification":
          return EventType.didReceiveRemoteNotification;
        default:
          return EventType.unknown;
      }
  }
}

/// SessionType
/// 
enum SessionType { P2P, team, chatroom, YSF, superTeam }
extension SessionTypeExt on SessionType {

  String rawValue() {
    switch (this) {
      case SessionType.P2P:
        return "P2P";
        break;
      case SessionType.team:
        return "team";
        break;
      case SessionType.chatroom:
        return "chatroom";
        break;
      case SessionType.YSF:
        return "YSF";
        break;
      case SessionType.superTeam:
        return "superTeam";
        break;
      default:
        return "P2P";
    }
  }
}
