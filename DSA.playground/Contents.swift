import UIKit

let dict = findCountOfCharacter(str: "Raja")

//let count = findTwoSum(nums: [2,7,11,15], target: 9)


//using task group to add numbers
func addNumber(arr:Int...) async ->[Int]{
    
    await withTaskGroup(of: Int.self) { group in
        for num in arr{
            group.addTask {
                //task 
                num * num
            }
        }
        var result = [Int]()
        for await value in group{
            result.append(value)
        }
        
        return result
    }
}


//Find Duplicates value or remove duplicate from given array
func findDuplicates(arr:Int...)->([Int:Int]){
    var notDu = [Int:Int]()
    for num in arr {
        if let val = notDu[num]{
            notDu[num] = val + 1
        }
        else{
            notDu[num] = 1
        }
    }
    return notDu
    
}

var array = [1, 3, 4, 5, 3, 4, 5, 7, 8]

let val = findDuplicates(arr: 1, 1, 2, 3, 4, 5, 6, 7, 7, 7, 7)
//Second approach to find duplicates
for (key,value) in val{
    var fi = [Int:Int]()
    if value > 1{
        fi[key] = val[key]
    }
    
    print("raja\(fi)")
}


print("Vishal \(val.filter { $0.value > 1 }.map({$0.key}))")

//Find ocurrence or count of each charcter in string
func findCountOfCharacter(str:String)->[Character:Int]{
    //In this Dictionary key is Charcter and value is count of charcter
    var freq = [Character:Int]()
    for char in str {
        if let count = freq[char] {
            freq[char] = count + 1
        } else {
            freq[char] = 1
        }
    }
    return freq
}


//Two Sum Problem Using HashMap (Swift)
////Problem
//Given an array of integers nums and a target target, find indices of two numbers such that they add up to the target.
//Assume exactly one solution exists and you may not use the same element twice.

func findTwoSum(nums:[Int],target:Int)->[Int]{
    //arayfo number and in target pass the sum
    var numToIndex: [Int: Int] = [:]
    //create a dictionary containing
    //traverse the array by enumerating index of number and number
    for(index,num) in nums.enumerated() {
        let complement = target - num//get the complement
        if let complementIndex = numToIndex[complement] {
            return[complementIndex,index]
            //If complemet number is present in dictionary find the index
        }
        numToIndex[num] = index
    }
    return []
}

//find longest substring without repeated charcter from given string
//it uses two pointer approach

func lonestSubString(str:String)->String{
    //Take set for this
    //convert string into array
    
    let array = Array(str)
    var left = 0
    var set = Set<Character>()
    var maxLength = 0
    var start = 0
    
    for right in 0..<array.count{
        //if set contains duplicate remove charcter and move left pointer forward
        while set.contains(array[right]){
            set.remove(array[left])
            left += 1
        }
        set.insert(array[right])
        
        
        // update maxlength
        if right - left + 1 > maxLength {
            maxLength = right - left + 1
            start = left
        }
    }
    
    return String(array[start..<start + maxLength])
}


print(lonestSubString(str: "bbbbb"))


//Stack implementaion using class

class Stack<T>{
    var elements : [T] = []
    //func
    
    func push(_ element:T){
        elements.append(element)
    }
    
    //remove top element
    func pop()->T?{
        return elements.popLast()
    }
    
    //peek element  `
    //return the top lement
    func peek()->T?{
        return elements.last
    }
    
    func isEmpty()->Bool{
        return elements.isEmpty
    }
    
    func showStack(){
        print("\(elements)")
    }
}


var stack = Stack<Int>()
stack.push(10)
stack.push(20)
stack.pop()
stack.showStack()

protocol Animal{
    func bark()
}

extension Animal{
    func bark(){
        print("Default Implementation")
    }
}
class Dog:Animal{
    func bark() {
        print("Dog Implemenation")
    }
}

var dog:Animal = Dog()
dog.bark()


class Box {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}


class Manager{
    var storedArray : [Box] = []
    
    func keepArray(array:[Box]){
        storedArray = array
    }
    
    func addNewBox(){
        storedArray.append(Box(value: 3))
    }
    //it will chnage 
    func changeFisrtBox(){
        storedArray[0].value = 100
    }
}

var outsideArray = [Box(value: 1), Box(value: 2)]
var  manager = Manager()
manager.keepArray(array: outsideArray)
manager.changeFisrtBox()
manager.addNewBox()
print("Inside array values:")
manager.storedArray.forEach { print($0.value) }
print("Outside array values:")
outsideArray.forEach { print($0.value) }


//Reverse the string using two pointer approach
func reverseString(_ str: String) -> String {
    var chars = Array(str)
    var left = 0
    var right = chars.count - 1

    while left < right {
        chars.swapAt(left, right)
        left += 1
        right -= 1
    }

    return String(chars)
}

//Capture List example
var language = "Objectiv-C"
let capturedLanguage = { [language] in
print("I Love \(language)")
}
language = "Swift"
capturedLanguage ()


//Check parenthesis problem of opening and closing bracket using stack
func isValid(_ s: String) -> Bool {
    var stack: [Character] = []
    //
    let matchingBrackets: [Character: Character] = [
        ")": "(",
        "}": "{",
        "]": "["
    ]
    
    for char in s {
        // If opening bracket, push to stack
        if char == "(" || char == "{" || char == "[" {
            stack.append(char)
        }
        // If closing bracket
        else if let expectedOpen = matchingBrackets[char] {
            
            print("vishal \(expectedOpen)")
            // Stack must not be empty and top must match
            if stack.isEmpty || stack.removeLast() != expectedOpen {
                return false
            }
        }
    }
    
    // Stack should be empty at the end
    return stack.isEmpty
}
print(isValid("({[]}"))

//Find the third Largest element from array

func thirdLargest(arr:[Int]){
    var largest = Int.min
    var secondLargest = Int.min
    var thirdLargest = 0
    
    for current in arr{
        if current > largest {
            thirdLargest = secondLargest
            secondLargest = largest
            largest = current
        }
        else if current > secondLargest{
            thirdLargest = secondLargest
            secondLargest = current
        }
        else if current > thirdLargest{
            thirdLargest = current
        }
    }
    
    print("Vishal\(thirdLargest)")
    print("Vishal\(secondLargest)")
    print("Vishal\(largest)")
}

//Find Third smallest element from given array
func thirdSmallest(arr: [Int]) {
    guard arr.count >= 3 else {
        print("Array must have at least 3 elements")
        return
    }

    var smallest = Int.max
    var secondSmallest = Int.max
    var thirdSmallest = Int.max

    for current in arr {
        if current < smallest {
            thirdSmallest = secondSmallest
            secondSmallest = smallest
            smallest = current
        }
        else if current < secondSmallest && current > smallest {
            thirdSmallest = secondSmallest
            secondSmallest = current
        }
        else if current < thirdSmallest && current > secondSmallest {
            thirdSmallest = current
        }
    }

    print("Third Smallest: \(thirdSmallest)")
    print("Second Smallest: \(secondSmallest)")
    print("Smallest: \(smallest)")
}

thirdLargest(arr: [2, 4, 6, 8, 10])


var arr = [0,0,2,0,3]

//Move all non zero element to right hand side
func moveAllZeroToRight(arr:inout[Int]){
    var currentIndex = 0//store the last index of zero elemet where we have to put non zero element
    for index in 0..<arr.count{
      if arr[index] != 0 {
        arr[currentIndex] = arr[index]
        currentIndex += 1
      }
    }
    
    while currentIndex<arr.count{
       arr[currentIndex] = 0
        currentIndex += 1
        print("Vishal \(arr)")
    }
   
}
moveAllZeroToRight(arr: &arr)
