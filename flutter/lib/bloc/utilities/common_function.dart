class CommonFunction {
  static const nowLabel = '今';
  static const minuteLabel = '分前';
  static const hourLabel = '時間前';
  static const dayLabel = '日前';
  static const monthLabel = 'ヶ月前';
  static const yearLabel = '年前';

  /// 対象時間がいつ投稿されたかをいい感じのフォーマットで表示
  static String timeAgo(DateTime time) {
    final now = DateTime.now();
    final timeSeconds = time.millisecondsSinceEpoch ~/ 1000;
    final nowSeconds = now.millisecondsSinceEpoch ~/ 1000;

    /// 今の時刻と対象時刻の時間差（秒）
    final difference = nowSeconds - timeSeconds;
    if (difference < 60) {
      // １分以内なら「今」と表示
      return nowLabel;
    } else if (difference < 60 * 60) {
      // 1時間以内ならX分前と表示
      final minuteDifference = difference ~/ 60;
      return '${minuteDifference}$minuteLabel';
    } else if (difference < 60 * 60 * 24) {
      // 1日以内ならX時間前と表示
      final hourDifference = difference ~/ (60 * 60);
      return '${hourDifference}$hourLabel';
    } else if (now.month == time.month) {
      // 1日以内ならX時間前と表示
      final daysDifference = difference ~/ (60 * 60 * 24);
      return '${daysDifference}$dayLabel';
    } else if (now.year == time.year) {
      // 投稿された年が同じ場合
      final monthDifference = now.month - time.month;
      return '${monthDifference}$monthLabel';
    } else {
      // 違う年に投稿された
      final yearDifference = now.year - time.year;
      return '${yearDifference}$yearLabel';
    }
  }
}
