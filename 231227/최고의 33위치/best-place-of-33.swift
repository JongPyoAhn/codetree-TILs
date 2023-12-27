let n = Int(readLine()!)!
var arr = [[Int]]()
var answer = 0

for i in 0..<n {
    arr.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

func search(x: Int, y: Int) -> Int {
    var coinCount = 0
    for i in x..<x+3 {
        for j in y..<y+3 {
            if arr[i][j] == 1 {
                coinCount += 1
            }
        }
    }
    return coinCount
}

for i in 0..<n-2 {
    for j in 0..<n-2 {
        answer = max(answer, search(x: i, y: j))
    }
}

print(answer)