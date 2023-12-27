let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
let m = nm[1]
var arr = [[Int]]()
for _ in 0..<n {
  arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

struct Mining {
  let cost: Int
  let goldCount: Int
  
  func profit() -> Int {
    let result = (goldCount * m) - cost
    if result < 0 {
      return 0
    }
    return goldCount
  }
}
var visited = [[Bool]]()
var goldCount = 0
func kSquare(i: Int, j: Int, k: Int) -> Mining {
  goldCount = 0
  visited = Array(repeating: Array(repeating: false, count: 1000), count: 1000)
  visited[i][j] = true
  if arr[i][j] == 1 {
    goldCount += 1
  }
  if k != 0 {
    confirmK(i: i, j: j, depth: 0, k: k)
  }
  let cost = k * k + (k + 1) * (k + 1)
  let mining = Mining(cost: cost, goldCount: goldCount)
  return mining
}


func confirmK(i: Int, j: Int, depth: Int, k: Int) {
  if depth == k {
    return
  }
  for idx in 0..<4 {
    let nx = i + dx[idx]
    let ny = j + dy[idx]
    if nx < 0 || ny < 0 || nx >= n || ny >= n { continue }
    if !visited[nx][ny] {
      if arr[nx][ny] == 1 {
        goldCount += 1
      }
    }
    visited[nx][ny] = true
    confirmK(i: nx, j: ny, depth: depth + 1, k: k)
  }
  return
}

var result = 0

for i in 0..<n {
  for j in 0..<n {
    for k in 0..<10 {
      let kResult = kSquare(i: i, j: j, k: k).profit()
      result = max(kResult, result)
    }
  }
}
print(result)