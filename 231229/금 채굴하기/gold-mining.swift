let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
let m = nm[1]
var arr = [[Int]]()
for _ in 0..<n {
  arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

struct Point {
  let x: Int
  let y: Int
}

func searchK() -> Int {
  return distance(point1: Point(x: 0, y: 0), point2: Point(x: n-1, y: n-1))
}

func distance(point1: Point, point2: Point) -> Int {
  return abs(point2.x - point1.x) + abs(point2.y - point1.y)
}

func simulate() -> Int {
  var result = 0
  let searchedK = searchK()

  for k in 0..<searchedK {
    for x1 in 0..<n {
      for y1 in 0..<n {
        let curPoint = Point(x: x1, y: y1)
        let goldCount = searchGold(curPoint: curPoint, k: k)
        if isProfit(m: m, goldCount: goldCount, k: k) {
          result = max(result, goldCount)
        }
      }
    }
  }
  return result
}

func searchGold(curPoint: Point, k: Int) -> Int {
  var goldCount = 0
  for x in 0..<n {
    for y in 0..<n {
      let searchedPoint = Point(x: x, y: y)
      let distance = distance(point1: curPoint, point2: searchedPoint)
      if distance <= k && arr[x][y] == 1 {
        goldCount += 1
      }
    }
  }
  return goldCount
}

func isProfit(m: Int, goldCount: Int, k: Int) -> Bool {
  guard (goldCount * m) >= cost(k: k) else { return false }
  return true
}

func cost(k: Int) -> Int {
  return (k * k) + ((k + 1) * (k + 1))
}

print(simulate())