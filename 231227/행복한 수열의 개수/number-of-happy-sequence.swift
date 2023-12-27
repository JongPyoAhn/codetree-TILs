let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
let m = nm[1]
var arr = [[Int]]()

for i in 0..<n {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

func search() -> Int {
    var totalSequenceCount = 0
    
    for i in 0..<n { 
        var continuousCount = 1
        var prevNumber = -1
        ///세로 행복수열 확인
        for j in 0..<n {
            if prevNumber == arr[i][j] {
                continuousCount += 1
            } else {
                continuousCount = 1
            }

            prevNumber = arr[i][j]

            if continuousCount == m {
                totalSequenceCount += 1
                break
            }
        }

        continuousCount = 1
        prevNumber = -1
        ///가로 행복수열 확인
        for j in 0..<n {
            if prevNumber == arr[j][i] {
                continuousCount += 1
            } else {
                continuousCount = 1
            }
            prevNumber = arr[j][i]
            if continuousCount == m {
                totalSequenceCount += 1
                break
            }
        }
    }
    return totalSequenceCount
}

print(search())