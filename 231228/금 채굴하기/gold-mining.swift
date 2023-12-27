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

func kSquare(i: Int, j: Int, k: Int) -> Mining {
  var cost = 0
  var goldCount = 0
  var visited = Array(repeating: Array(repeating: false, count: n), count: n)
  visited[i][j] = true
  cost += 1
  if arr[i][j] == 1 {
    goldCount += 1
  }
  if k != 0 {
    for idx in 0..<4 {
      let nx = i + dx[idx]
      let ny = j + dy[idx]
      if nx < 0 || ny < 0 || nx >= n || ny >= n || visited[nx][ny] { continue }
      visited[nx][ny] = true
      cost += 1
      if arr[nx][ny] == 1 {
        goldCount += 1
      }
      if k == 2 {
        for idx in 0..<4 {
          let nnx = nx + dx[idx]
          let nny = ny + dy[idx]
          if nnx < 0 || nny < 0 || nnx >= n || nny >= n || visited[nnx][nny] { continue }
          visited[nnx][nny] = true
          cost += 1
          if arr[nnx][nny] == 1 {
            goldCount += 1
          }
        }
      }
    }
  }
  let mining = Mining(cost: cost, goldCount: goldCount)
  return mining
}

var result = 0

for i in 0..<n {
  for j in 0..<n {
    let k0 = kSquare(i: i, j: j, k: 0).profit()
    let k1 = kSquare(i: i, j: j, k: 1).profit()
    let k2 = kSquare(i: i, j: j, k: 2).profit()
    result = max(k0, k1, k2, result)
  }
}
print(result)