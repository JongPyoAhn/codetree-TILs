let n = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

struct Rectangle {
  let point: Point
  let bottomLength: Int
  let rightLength: Int
  let topLength: Int
  let leftLength: Int
  
  func compare() -> Bool {
    guard bottomLength == topLength && leftLength == rightLength else { return false }
    return true
  }
}

struct Point {
    let x: Int
    let y: Int
}

let dx = [-1, -1, 1, 1]
let dy = [1, -1, -1, 1]

func rightUp(rectangle: Rectangle, sum: Int) -> Int {
  let nx = rectangle.point.x + dx[0]
  let ny = rectangle.point.y + dy[0]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || rectangle.bottomLength >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let nPoint = Point(x: nx, y: ny)
  let answer1 = leftUp(
    rectangle: Rectangle(
      point: nPoint,
      bottomLength: rectangle.bottomLength,
      rightLength: 1,
      topLength: 0,
      leftLength: 0
    ),
    sum: nSum
  )
  
  let answer2 = rightUp(
    rectangle: Rectangle(
      point: nPoint,
      bottomLength: rectangle.bottomLength + 1,
      rightLength: rectangle.rightLength,
      topLength: rectangle.topLength,
      leftLength: rectangle.leftLength
    ),
    sum: nSum
  )
  
  return max(answer1, answer2)
}

func leftUp(rectangle: Rectangle, sum: Int) -> Int {
  let nx = rectangle.point.x + dx[1]
  let ny = rectangle.point.y + dy[1]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || rectangle.rightLength >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let nPoint = Point(x: nx, y: ny)
  
  let answer1 = leftDown(
    rectangle:
      Rectangle(
        point: nPoint,
        bottomLength: rectangle.bottomLength,
        rightLength: rectangle.rightLength,
        topLength: 1,
        leftLength: 0
      ),
    sum: nSum
  )
  
  let answer2 = leftUp(
    rectangle: 
      Rectangle(
        point: nPoint,
        bottomLength: rectangle.bottomLength,
        rightLength: rectangle.rightLength + 1,
        topLength: 0,
        leftLength: 0
      ),
    sum: nSum
  )
  
  return max(answer1, answer2)
}

func leftDown(rectangle: Rectangle, sum: Int) -> Int {
  let nx = rectangle.point.x + dx[2]
  let ny = rectangle.point.y + dy[2]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || rectangle.topLength >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let nPoint = Point(x: nx, y: ny)

  let answer1 = rightDown(
    rectangle:
      Rectangle(
        point: nPoint,
        bottomLength: rectangle.bottomLength,
        rightLength: rectangle.rightLength,
        topLength: rectangle.topLength,
        leftLength: 1
      ),
    sum: nSum
  )
  
  let answer2 = leftDown(
    rectangle:
      Rectangle(
        point: nPoint,
        bottomLength: rectangle.bottomLength,
        rightLength: rectangle.rightLength,
        topLength: rectangle.topLength + 1,
        leftLength: 0
      ),
    sum: nSum
  )

  return max(answer1, answer2)
}

func rightDown(rectangle: Rectangle, sum: Int) -> Int {
  let nx = rectangle.point.x + dx[3]
  let ny = rectangle.point.y + dy[3]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || rectangle.leftLength >= n {
    return 0
  }
  
  let nSum = sum + arr[nx][ny]

  let nPoint = Point(x: nx, y: ny)

  if rectangle.compare() {
    return nSum
  }

  return rightDown(
    rectangle:
      Rectangle(
        point: nPoint,
        bottomLength: rectangle.bottomLength,
        rightLength: rectangle.rightLength,
        topLength: rectangle.topLength,
        leftLength: rectangle.leftLength + 1
      ),
    sum: nSum
  )
}

var result = 0

for i in 0..<n {
  for j in 0..<n {
    result = max(
      result,
      rightUp(
        rectangle: Rectangle(
          point: Point(x: i, y: j),
          bottomLength: 1,
          rightLength: 0,
          topLength: 0,
          leftLength: 0
        ),
        sum: 0
      )
    )
  }
}

print(result)