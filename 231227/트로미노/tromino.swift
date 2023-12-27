let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n, m) = (nm[0], nm[1])
var arr = [[Int]]()

for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

func reverseThreeBlock(x: Int, y: Int) -> Int {
    if y + 1 >= m || x - 1 < 0 { return -1 }
    return arr[x][y] + arr[x][y + 1] + arr[x - 1][y + 1]
}


func commonThreeBlockShape(x: Int, y: Int) -> Int {
    if x + 1 >= n || y + 1 >= m { return -1 }
    let s = arr[x][y] + arr[x + 1][y] + arr[x + 1][y + 1]
    let r = arr[x][y] + arr[x][y + 1] + arr[x + 1][y + 1]
    let reverseR = arr[x][y] + arr[x][y + 1] + arr[x + 1][y]
    return max(s, r, reverseR)
}

func widthBlock(x: Int, y: Int) -> Int {
    if y + 2 >= m { return -1 }
    return arr[x][y] + arr[x][y + 1] + arr[x][y + 2]
}

func heightBlock(x: Int, y: Int) -> Int {
    if x + 2 >= n { return -1 }
    return arr[x][y] + arr[x + 1][y] + arr[x + 2][y]
}

func search() -> Int {
    var maxResult = -1
    for i in 0..<n {
        for j in 0..<m {
            maxResult = max(reverseThreeBlock(x: i, y: j), commonThreeBlockShape(x: i, y: j), widthBlock(x: i, y: j), heightBlock(x: i, y: j), maxResult)
        }
    }
    return maxResult
}

print(search())