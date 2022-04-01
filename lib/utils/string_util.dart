/// StringUtil工具类
class StringUtil {
  /// List转String 中间默认顿号拼接。其它字符自定义，比如逗号，splitChar参数传'，'
  static String listToString(List<String?> list, {String splitChar = '、'}) {
    var str = '';
    if (list.isEmpty) {
      return '';
    }
    str = list.join(splitChar);
    return str;
  }

  //Text overflow: TextOverflow.ellipsis,
  // 缺陷： 会将长字母、数字串整体显示省略,现象： ￥ 100000000000，会出现：￥ ...
  ///将每个字符串之间插入零宽空格
  static String? breakWord(String? word) {
    if (word == null || word.isEmpty) {
      return word;
    }
    var breakWord = ' ';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}
