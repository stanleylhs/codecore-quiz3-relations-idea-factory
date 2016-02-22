var isEven = function (x) { return x % 2 == 0; };
var filter = function (arr, fn) {
  var newArray = [];
  arr.forEach(function (x){
      if (fn(x)) {
          newArray.push(x);
      }
  });
  return newArray;
};
filter([1, 2, 3, 4], isEven);