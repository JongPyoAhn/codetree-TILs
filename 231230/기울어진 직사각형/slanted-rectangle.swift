let n = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

struct Point {
    let x: Int
    let y: Int
}

let dx = [-1, -1, 1, 1]
let dy = [1, -1, -1, 1]

func rightUp(x: Int, y: Int, bottom: Int, sum: Int) -> Int {
  let nx = x + dx[0]
  let ny = y + dy[0]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || bottom >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let answer1 = leftUp(x: nx, y: ny, bottom: bottom, right: 1, sum: nSum)
  
  let answer2 = rightUp(x: nx, y: ny, bottom: bottom + 1, sum: nSum)
  
  return max(answer1, answer2)
}

func leftUp(x: Int, y: Int, bottom: Int, right: Int, sum: Int) -> Int {
  let nx = x + dx[1]
  let ny = y + dy[1]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || right >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let answer1 = leftDown(x: nx, y: ny, bottom: bottom, right: right, top: 1, sum: nSum)
  
  let answer2 = leftUp(x: nx, y: ny, bottom: bottom, right: right + 1, sum: nSum)
  
  return max(answer1, answer2)
}

func leftDown(x: Int, y: Int, bottom: Int, right: Int, top: Int, sum: Int) -> Int {
  let nx = x + dx[2]
  let ny = y + dy[2]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || top >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  let answer1 = rightDown(x: nx, y: ny, bottom: bottom, right: right, top: top, left: 1, sum: nSum)
  
  let answer2 = leftDown(x: nx, y: ny, bottom: bottom, right: right, top: top + 1, sum: nSum)

  return max(answer1, answer2)
}

func rightDown(x: Int, y: Int, bottom: Int, right: Int, top: Int, left: Int, sum: Int) -> Int {
  let nx = x + dx[3]
  let ny = y + dy[3]
  
  if nx < 0 || ny < 0 || nx >= n || ny >= n || left >= n {
    return 0
  }

  let nSum = sum + arr[nx][ny]

  if bottom == top && left == right {
    return nSum
  }

  return rightDown(x: nx, y: ny, bottom: bottom, right: right, top: top, left: left + 1, sum: nSum)
}

var result = 0

for i in 0..<n {
  for j in 0..<n {
    result = max(result, rightUp(x: i, y: j, bottom: 1, sum: 0))
  }
}

print(result)