class Utils {
  static getInputFloat = input => {
    return $(input).val() ? parseFloat($(input).val()) : 0;
  };

  static sumInputFloats = inputs => {
    return Array.from(inputs)
      .map(i => Utils.getInputFloat(i))
      .reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  }

  static generateId = () => {
    var delim = '-';

    function S4() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }

    return S4() + S4() + delim + S4() + delim + S4() + delim + S4() + delim + S4() + S4() + S4();
  }
}

export default Utils;
