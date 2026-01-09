import UIKit

var greeting = "Hello, playground"
//Remove duplicates
func removeDuplicate(str:[Int])->[Int]{
    let array = Array(str)
    var dupicate = [Int]()
    
    for val in array{
        if !dupicate.contains(val){
            dupicate.append(val)
        }
    }
    
    return dupicate
}

//Second Trick
let arr = [1,3,2,12,12,1]
var set = Set(arr)
print(set)

//Merge intervals problem
func mergeIntervals(intervals:[[Int]])->[[Int]]{
    var finalMerged = [[Int]]()
    let soretd: [[Int]] = intervals.sorted { num1, num2 in
        num1[0] < num2[0]
    }
    
    var prsent = soretd[0]
    
    for next in soretd {
        if prsent[1] >= next[0]{
            prsent[1] = max(prsent[1], next[1])
        }
        else{
            finalMerged.append(prsent)
            prsent = next
        }
    }
    
    //last append
    
    finalMerged.append(prsent)
    
    return finalMerged
}

//longest susbstring without repeating with two pointer

func lonestSubString(str:String)->String{
    
    
    var right = 0
    var left = 0
    var set = Set<Character>()
    var maxlength = 0
    var start = 0
    var array = Array(str)
    for right in 0..<array.count{
        while set.contains(array[right]){
            set.remove(array[left])
            left += 1
        }
        set.insert(array[right])
        if right - left + 1 > maxlength {
            maxlength =  right - left + 1
            start = left
        }
    }
    
    return String(array[start..<start+maxlength])
}

//lonestSubString(str: "abccbbbb")

//longest prefix
func prefixFind(arr:[String])->String{
    //
    var prefix = arr[0]
    for i in 1..<arr.count{
        var next = arr[i]
        while !next.hasPrefix(prefix){
            prefix.removeLast()
            if prefix.isEmpty {
                return ""
            }
        }
    }
    return prefix
}

//print(prefixFind(arr: ["flower","flow","fl"]))

enum player:Character{
    case X = "X"
    case O = "O"
}

let pla:player = .O
print(pla)

let board : [[String]] = [
    ["X", "X", "O"],
    ["X", "O", "O"],
    ["0", "O", "X"]
]
func playerwin(baord:[[String]])->String? {
    //row
    for row in 0..<baord.count {
        if baord[row][0] != " " &&
            baord[row][0] == baord[row][1] &&
            baord[row][1] == baord[row][2]{
            return baord[row][0]
        }
    }
    //coloumn
    for col in 0..<baord.count {
        if baord[0][col] != " " &&
            baord[0][col] == baord[1][col] &&
            baord[1][col] == baord[2][col]{
            return baord[col][0]
        }
    }
    
    //diagonal
    
    if baord[0][0] != " " &&
        board[0][0] == board[1][1] &&
        baord[1][1] == board[2][2]{
        return baord[0][0]
    }
    
    if baord[0][2] != " " &&
        board[0][2] == board[1][1] &&
        baord[1][1] == board[2][0]{
        return baord[0][2]
    }
    return nil
    
}

//Stack Implementation

struct Stack{
    var elements = [Int]()
    
    mutating func push(element:Int){
        elements.append(element)
    }
    
    mutating func pop()->Int? {
        elements.popLast()
    }
    
    func peek()->Int?{
        elements.last
    }
    
    func traverse(){
        print("Vishal \(elements)")
    }
}


var stack1 = Stack()
stack1.push(element: 1)
stack1.push(element: 2)
stack1.peek()
stack1.traverse()
if let player = playerwin(baord: board){
    print("Vishal \(player)")
}

//Find parenthesis
func isValid(arr:String)->Bool{
    var stack = [Character]()
    //make dictionary
    let matching : [Character:Character] = ["]" : "[",
                    "}" : "{"]
    for val in arr{
        if val == "[" || val == "{"{
            stack.append(val)
        }
        else{
            if let expected = matching[val]{
                if stack.isEmpty || expected != stack.popLast(){
                    return false
                }
            }
        }
    }
    
    return stack.isEmpty
}

//SDk Design Interview
enum PlayerState{
    case Playing
    case Paused
}

//optional

struct PlayerConfiguration{
    public var autoPlay: Bool
    public var isMuted: Bool
    init(autoPlay: Bool = false, isMuted: Bool = false) {
        self.autoPlay = autoPlay
        self.isMuted = isMuted
    }
}

//PlayerSdk class

protocol PlayerSDKProtocol{
    var state:PlayerState{get}
    var delaget:PlayerSDKDelegate? {get set}
    func play()
    func pasue()
    func setMute(mute:Bool)
}

class PlayerSDK:PlayerSDKProtocol{
    weak var delaget:  PlayerSDKDelegate?
    private(set) var state: PlayerState = .Playing
    let voideoId:Int
    var config:PlayerConfiguration
    init(voideoId: Int, config: PlayerConfiguration = PlayerConfiguration()) {
        self.voideoId = voideoId
        self.config = config
    }
    
    func play() {
        state = .Playing
        delaget?.playerDidPlay(self, state: state)
    }

    func pasue() {
        state = .Paused
        delaget?.playerDidPause(self, state: state)
    }

    func setMute(mute: Bool) {
        self.config.isMuted = mute
        delaget?.playerDidPause(self, state: state)
    }

   
    
}

 protocol PlayerSDKDelegate: AnyObject {
     func playerDidPlay(_ player: PlayerSDK,state:PlayerState)
    func playerDidPause(_ player: PlayerSDK,state:PlayerState)
    func playerDidFinish(_ player: PlayerSDK,state:PlayerState)
}


class App1:UIViewController{

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let player = PlayerSDK(voideoId: 1234)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delaget = self
    }
}

extension App1:PlayerSDKDelegate{
    func playerDidPlay(_ player: PlayerSDK, state: PlayerState) {
        
        player.state
        
    }

    func playerDidPause(_ player: PlayerSDK, state: PlayerState) {
        <#code#>
    }

    func playerDidFinish(_ player: PlayerSDK, state: PlayerState) {
        <#code#>
    }

    
}
