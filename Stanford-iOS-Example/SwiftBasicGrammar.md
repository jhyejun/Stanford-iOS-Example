#  스위프트 기초 문법을 공부하자

## 옵셔널이 뭐길래

옵셔널은 enum 형태로 이루어져 있고, 옵셔널은 사용하는 건 switch 문의 방식으로 생각하면 된다.<br>

```
enum Optional<T> {  // <T> 가 뜻하는 바는 모든 타입의 옵셔널이 될 수 있다는 뜻
    case None
    case Some(T)
}
```
<br>

옵셔널 변수 x 가 있고 옵셔널 변수 x를 y에 저장할 때는 switch 문의 방식으로 생각하면 된다.

```
switch x {
    case Some(let value): y = value
    case None:  // None 일 때의 할 행동이 정의되어 있지 않아 충돌이 나게 되어 있음
}
```

하지만 충돌을 피하기 위해 if let을 사용해 옵셔널 변수인 x를 y에 저장하는 경우는 방금 전과 다른 swtich 문의 방식이다.

```
switch x {
    case Some(let value):
        y = value
    case None:
        break   // None 일 때의 할 행동이 break 이기 때문에 충돌나지 않고 그냥 지나가게 되어 있음
}
```
<br>

### 옵셔널 체이닝
옵셔널을 사용하기 위한 ?, !는 단순한 구문표현법이고 더 단순한 표현법인 옵셔널 체이닝이 있다.<br>
옵셔널 체이닝은 옵셔널을 사슬처럼 연결해줄 수 있다.<br>

```
var display: UILabel?

if let label = display {
    if let text = label.text {
        let x = tex.hashValue
    }
}
```

옵셔널을 안전하게 사용하기 위해 if let 으로 계속 벗겨내는 코드다.<br>
딱 보면 알 듯이 한눈에 보기 힘들다.<br>
하지만 옵셔널 체이닝을 통해 한줄로 줄일 수 있다.<br>

```
if let value = display?.text?.hashValue
```

옵셔널을 선언할 때가 아닌 옵셔널 값을 사용하려 할 때 ? 를 사용하게 되면<br>
일단 추출을 해보고 추출을 할 수 있다면 그 값을 이용해 다음으로 넘어가지만,<br>
추출 할 수 없다면 전체 표현식에서 nil 을 반환한다.<br>
어느 지점에서든 추출할 수 없다고 판단이 되면 그 전체 표현식은 nil 이 된다.<br>
<br>

### 옵셔널 디폴팅
또 다른 ?? 이라는 옵셔널 구문이 있다.<br>
옵셔널이 nil 일 때 기본값을 설정해주는 구문이다.

```
let s: String? = nil

if s != nil {
    display.text = s
}

else {
    display.text = " "
}
```

옵셔널인 변수가 nil 일 때 " " 공백을 주기 위한 코드인데 이 코드도 간결하게 한 줄로 줄일 수 있다.

```
display.text = s ?? " "
```

---

## 스위프트와 파운데이션 1 : Tuples, Range, Data Structure

### 튜플 (Tuples)
서로 다른 타입들을 그룹으로 묶어서 하나의 타입을 만든다.<br>
타입이 들어갈 자리라면 튜플을 어디에서든 사용 가능하다.

```
let x: (String, Int, Double) = ("hello", 5, 0.85) // 튜플 생성
let (word, number, value) = x
print(word)     // prints hello
print(number)   // prints 5
print(value)    // prints 0.85
```
위의 코드는 튜플을 생성하고 튜플을 word, number, value 에 할당하고 출력한다.

```
let x: (w: String, i: Int, v: Double) = ("hello", 5, 0.85)
print(x.w) // prints hello
print(x.i) // prints 5
print(x.v) // prints 0.85
```
이 코드는 튜플을 생성하는 동시에 할당해서 출력한다.

```
func getSize() -> Double { return  }
// 일반적인 Double 반환 타입 함수

func getSize() -> (weight: Double, height: Double) { 
    return (250, 80)
} // 튜플 반환 타입의 함수

let x = getSize()
print("weight is \(x.weight)") // weight is 250
print("height is \(getSize().height)") // height is 80
```

튜플은 완벽하게 유효한 반환 타입이 될 수 있으며 여러 개의 값을 반환할 수 있다.

---

### Range
무엇이든 연속적으로 표현될 수 있는 것의 양 끝 점을 가르킨다.<br>
Range는 Array처럼 일반화 된 타입이기 떄문에<br>
Int로 된 Range나 무언가의 인덱스로 된 Range도 될 수 있다.<br>
Range는 이렇게 구성되어 있다.

```
struct Range<T> {
    var startIndex: T
    var endIndex: T
}
```


대표적으로 사용되는 Range의 예시이다.
```
let array = ["a", "b", "c", "d"]
let subArray1 = array[2...3]    // subArray1 will be ["c", "d"]
let subArray2 = array[2..<3]    // subArray2 will be ["c"]
for i in 27...104 { }           // Range is enumeratable, like Array, String, Dictionary
```

---

### Data Structures in Swift
Class, Struct, Enum 유사점과 차이점

유사점
- 모두 똑같은 방법으로 선언이 된다.<br>
(키워도 + 이름 + {} 구조)
- 모두 프로퍼티와 함수를 가질 수 있다.<br>
(다만 enum은 저장 프로퍼티를 가질 수 없지만 계산 프로퍼티는 가질 수 있다.<br>
enum이 기억하고 있는 저장소는 case이며 case에는 연관값이 있다.)
- Initializer(초기화 함수)를 가질 수 있다.<br>
(enum만 제외하고 초기화 함수를 가지도록 되어있다.<br>
연관값을 구별되는 값들에 할당해주기 때문에 enum은 초기화 함수를 가질 필요가 없다.)

차이점
- 클래스에서는 상속을 할 수 있지만, struct와 enum은 불가능하다.
- struct와 enum은 값으로 전달되는 값 타입, 클래스는 참조 타입으로<br>
포인터(메모리 주소)로 전달되고 힙(동적으로 할당되는 메모리 영역) 메모리에 있다.

구조체를 사용할 때는<br>
클래스보다는 더 작고 스스로 자립하며 값으로<br>
복사되는 게 말이 되고 값 타입을 원할 때 사용한다.<br>
(String, Int 같은 타입이나 그림을 그리기 위한 점, 직사각형)<br>
위에 해당사항이 없다면 클래스를 선택하면 된다.<br>
대부분 큰 것은 클래스를 사용하게 된다.