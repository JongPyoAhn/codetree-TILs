let n = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

struct Point {
    let x: Int
    let y: Int
}

let dist = n / 2

var visited = [[Bool]]()

var answer = 0

for k in 1...dist {
    for i in 0..<n {
        for j in 0..<n {
          
            let curPoint = Point(x: i, y: j)
          visited = Array(repeating: Array(repeating: false, count: n), count: n)
            let leftValue = leftSearch(k: k, curPoint: curPoint, prevValue: 0)
          if i == 4 && j == 1{
            
          }
          visited = Array(repeating: Array(repeating: false, count: n), count: n)
            let rightValue = rightSearch(k: k, curPoint: curPoint, prevValue: 0)
            
            answer = max(answer, leftValue, rightValue)
        }
    }
}
print(answer)

func leftSearch(k: Int, curPoint: Point, prevValue: Int) -> Int {
    var result = prevValue
    var curPoint = curPoint
    let dx = [-1, -1, 1, 1]
    let dy = [1, -1, -1, 1]

    for i in 0..<4 {
        for _ in 0..<k {
            let nx = curPoint.x + dx[i]
            let ny = curPoint.y + dy[i]

            ///해당 크기의 정사각형 모양을 만들 수 없음
            if nx < 0 || ny < 0 || nx >= n || ny >= n {
                return prevValue
            }
            if !visited[nx][ny] {
                result += arr[nx][ny]
                visited[nx][ny] = true
            }
            curPoint = Point(x: nx, y: ny)
        }
    }
    /// 좌 탐색
    if curPoint.x - k >= 0 && curPoint.y - k >= 0 && (curPoint.x - k * 2) >= 0 {
        let nextPoint = Point(x: curPoint.x - k, y: curPoint.y - k)
        result = max(result, leftSearch(k: k, curPoint: nextPoint, prevValue: result))
    }
    return result
}

func rightSearch(k: Int, curPoint: Point, prevValue: Int) -> Int {
    var result = prevValue
    var curPoint = curPoint
    let dx = [-1, -1, 1, 1]
    let dy = [1, -1, -1, 1]

    for i in 0..<4 {
        for _ in 0..<k {
            let nx = curPoint.x + dx[i]
            let ny = curPoint.y + dy[i]
          
            ///해당 크기의 정사각형 모양을 만들 수 없음
            if nx < 0 || ny < 0 || nx >= n || ny >= n {
                return prevValue
            }
            if !visited[nx][ny] {
                result += arr[nx][ny]
                visited[nx][ny] = true
            }
            curPoint = Point(x: nx, y: ny)
        }
    }
    /// 우 탐색
    if curPoint.x - k >= 0 && curPoint.y + k >= 0 && (curPoint.x - k * 2) >= 0 {
        let nextPoint = Point(x: curPoint.x - k, y: curPoint.y + k)
        return rightSearch(k: k, curPoint: nextPoint, prevValue: result)
    }
    return result
}