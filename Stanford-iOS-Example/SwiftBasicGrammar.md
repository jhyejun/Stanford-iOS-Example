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

---

## 스위프트와 파운데이션 2 : Method와 Property

### 메소드 (Method)
메소드 정의할 때 파라미터를 외부 이름과 내부 이름으로 구분해 정의할 수 있다.<br>
순서는 외부 이름이 먼저 오고 내부 이름이 그 뒤에 온다.<br>
내부 이름은 메소드 내에서 사용될 지역 변수 이름이고,<br>
외부 이름은 메소드를 호출할 때 사용한다.<br> 

```
func foo(externalFirst first: Int, externalSecond second: Double) {
    var sum = 0.0
    for _ in 0..<first { sum += second }
}

func bar() {
    let result = foo(externalFirst: 100, externalSecond: 5.0)
}
```

외부 이름을 전혀 사용하고 싶지 않다면 외부이름으로 '_' 을 사용하면 된다.

```
func foo(_ first: Int, externalSecond second: Double) {
    var sum = 0.0
    for _ in 0..<first { sum += second }
}

func bar() {
    let result = foo(100, externalSecond: 5.0)
}
```

첫번째 파라미터에는 외부 이름에 언더바가 기본으로 설정되어 있어서<br>
함수를 새로 만들 때 언더바를 넣어줄 필요가 없다.<br>
<br>

첫번째 파라미터를 제외한 다른 파라미터들은 외부 이름 기본값이 내부 이름이라서<br>
외부 이름을 지정하지 않으면 기본값인 내부 이름으로 지정 된다.<br>
두번째 파라미터부터 외부 이름을 지울 수 있고,<br>
첫번째 파라미터의 외부 이름을 추가해 줄 수 있지만<br>
이는 스위프트에 반하는 표현이다.<br>
첫번째 파리미터 이후로 이어지는 파라미터들을 없애는 건 정말 좋지 않다.<br>
<br>

메소드는 오버라이드를 할 수 있다.<br>
오버라이드는 상위 클래스에서 정의된 메소드와 프로퍼티를 다시 정의한다는 걸 뜻한다.<br>
쉽게 말하면 **덮어쓰기**다.<br>
사용하는 방법은 var 나 func 앞에 'override'를 키워드를 달아주면 된다.<br>
<br>

또한 프로퍼티와 메소드는 final로 표시할 수 있다.<br>
final 키워드는 아무도 서브클래싱을 하지 못하게 하는 것인데<br>
서브클래싱은 하위 클래스에서 오버라이드 등을 통해 수정하는 걸 뜻한다.<br>
따라서 서브클래싱을 못하게 되면 오버라이드도 할 수 없다.<br>
범위를 넓혀서 클래스 전체에 final을 붙이면 클래스 전체를 서브클래싱 할 수 없게 된다.<br>

### 프로퍼티 (Property)

프로퍼티는 스위프트에서 정말 유용하다.<br>
유용한 이유 중 하나는 프로퍼티의 변화를 알 수 있기 때문이다.

```
var someStoredProperty: Int = 42 {
    willSet { newValue is the new value } // 설정되기 전 호출
    didSet { oldValue is the old value } // 설정된 후 호출
}

override var inheritedProperty {
    willSet { newValue is the new value } // 설정되기 전 호출
    didSet { oldValue is the old value } // 설정된 후 호출
}
```

위의 코드는 계산 프로퍼티가 아니라 저장 프로퍼티 코드이다.<br>
willSet은 프로퍼티라 설정되기 전에 호출되고<br>
didSet은 프로퍼티가 설정된 후에 호출된다.<br>

willSet의 newValue는 willSet에서 새로 설정될 값이 들어가고<br>
didSet의 oldValue는 didSet이 실행되면 전에 갖고 있던 값이 들어온다.<br>

저장 프로퍼티나 상속된 프로퍼티에서 사용할 수 있고<br>
계산 프로퍼티에서도 할 수 있다.<br>

willSet과 didSet으로 많이 사용하는 것은 UI를 업데이트 하는 것이다.<br>
컨트롤러에 메소드가 있고 UI가 보이는 방식을 바꿀 컨트롤러에 어떤 값을 설정하면<br>
뷰에게 스스로 다시 그려내라고 요청할 수 있디.<br>
<br>

**lazy initialization(늦은 초기화)**<br>
이건 스위프트에서 약간 속이는 코드표현인데<br>
var가 늦게 초기화되도록 선언할 수 있다.<br>

```
// nice if CaculatorBrain used lots of resources
lazy var brain = CaculatorBrain()

lazy var someProperty: Type = {
    // construct the value of someProperty here
    return <the constructed value>
}()

lazy var myProperty = self.initializeMyProperty()
```

그 말은 변수의 값(CaculatorBrain)을<br>
누군가가 변수에게 요청하기 전까진 할당되지 않는다.<br>
누가 그 변수의 프로퍼티나 메소드를 사용하려 하면<br>
그 때가 되어서야 초기화 되는 것이다.<br>
**음식점으로 치면 주문이 들어와야 조리를 시작하는 것**과 같다.<br>
<br>

세번째 코드(myProperty)는<br>
내 프로퍼티를 직접 메소드를 호출해서 초기화 하려는 건데<br>
보통 lazy 키워드 없이는 잘못된 코드이다<br>

여기에서 lazy가 없으면 안되는 이유는<br>
전체적으로 초기화되기 전까지는 자신에게 메시지를 보내거나<br>
모든 프로퍼티에 접근할 수 없기 때문이다.<br>
하지만 lazy를 통해서는 할 수 있다.<br>
lazy에 대해 설명했다시피<br>
모두 초기화가 되고 난 뒤 내 프로퍼티에 접근하기 전까지는<br>
실제로 실행되지 않을 거이기 때문에<br>
lazy를 통해서는 세번째 코드가 작동한다.<br>
<br>

이게 속이는 코드라고 하는 이유는<br>
lazy가 늦게라도 초기화된다고 해도<br>
모든 변수는 초기화돼야한다는 규칙을 따라 초기화되고 있는 것이기 떄문<br>
lazy는 자주 초기화 함수를 작성하지 않아도 되도록 해주고<br>
init 메소드가 필요하지 않을 수도 있다.<br>
늦게라도 초기화를 할 테니까<br>

lazy는 var만 사용할 수 있다.<br>
lazy는 변수간 의존성에서 생기는 문제를 극복하는 데에도 쓰일 수 있다.<br>
다른 변수에 의존하고 있는 변수 하나가 있다면<br>
둘 중 하나를 lazy로 만들어서 의존성에서 생기는 문제를 극복할 수 있다.<br>
lazy로 만든 변수가 미리 초기화된 변수를 부를거기 때문이다.<br>

---

## 스위프트와 파운데이션 3 : Array, Dictionary, String

### 배열 (Array)
```
var a = Array<String>()
... is the same as ...
var a = [String]()

let animals = ["Giraffe", "Cow", "Doggie", "Bird"]
```
위에 두줄은 비어있는 String 타입의 배열을 생성한다는 같은 코드이다.<br>

animals는 값을 넣어서 배열을 생성하는 것이다.<br>

```
// enumerating an Array
for animal in animals {
    println("\(animal)")
}
```
반복을 해가면서 지역변수에 animals 가 각각 할당되면서<br>
Array 안에 있는 모든 요소들을 열거할 수 있다.<br>

다음 Array 메소드를 사용하면 for문이나 if문을 장황하게 늘어놓지 않고<br>
한 줄로 사용 가능하다.<br>

```
filter(includeElement: (T) -> Bool) -> [T]

let bigNumbers = [2, 47, 118, 5, 9].filter({ $0 > 20})
// bigNumbers = [47, 118]
```

**filter**는 Array에 있는 메소드이다.<br>
Array에 있는 무슨 타입이든 받아서 Bool을 반환하는 클로져를 제공하는 메소드다.<br>
Array의 모든 요소마다 클로져를 실행해서<br>
클로져가 true로 반환하는 요소는 새 Array에 포함시키고<br>
true가 아닌 요소들은 제외한다.<br>
그렇게 새롭게 만들어진 Array를 filter가 반환한다.<br>
<br>

또 다른 것으로 **map**이라는 더 비슷한 메소드가 있다.<br>

```
map(transform: (T) -> U) -> [U]

let stringfield: [String] = [1, 2, 3].map { String($0) }
```

map은 클로져를 받고 클로져는 Array안에 있는각 요소들을 다른 것으로 바꾸는 메소드다.<br>

위의 stringfield 부분은 Int로 된 Array를<br>
map { String($0) } 을 통해<br>
String으로 된 Array로 바꾸는 부분이다.<br>

만약 클로져가 함수의 마지막 인자일 때 소괄호 밖으로 나올 수 있다.<br>

**reduce**라고 불리는 또 다른 함수가 있다.

```
reduce(initial: U, combine: (U, T) -> U) -> U

// adds up the numbers in the Array
let sum: Int = [1, 2, 3].reduce(0) { $0 + $1 }
```

reduce는 Array를 하나의 결과로 줄이는 메소드다.<br>

위의 sum 부분은 초기값을 0으로 설정한 다음<br>
{ $0 + $1 } 의 클로져를 사용해서 배열 요소들을 줄이는 부분이다.<br>

설명하자면, 3개의 요소들 중 먼저 앞의 두개의 요소가 클로져를 통해 합쳐져<br>
한개의 요소가 되어서 총 2개의 요소가 되었다.<br>
남은 두개의 요소도 클로져를 통해 합쳐져 한 개의 요소가 되면 반환한다.<br>

이처럼 여러개의 요소를 한 개의 요소로 줄이는 것이다.<br>

그런데 여기서도 클로져가 소괄호 밖에 나와 있는게 보인다.<br>
이걸 **트레일링 클로져 문법**이라고 부른다.<br>

**트레일링 클로져 문법**이란<br>
메소드에서 인자가 클로져밖에 없거나 클로져가 마지막 인자일 때 클로져 부분을<br>
작은 괄호 밖으로 꺼낼 수 있는 걸 뜻한다.<br>
인자가 클로져밖에 없을 경우는 작은 괄호가 아예 없어도 된다.<br>

이 트레일링 클로져 문법 때문에 코드 읽기가 정말 수월하다.<br>

### 딕셔너리 (Dictionary)
Dictionary는 Array와 비슷하다.<br>
key와 value로 되어 있는 Array라고 생각하면 된다.<br>

```
var pac10teamRankings = Dictionary<String, Int>()
... is the same as ...
var pac10teamRankings = [String: Int]()

pac10teamRankings = ["Stanford": 1, "Cal": 10]
```
위에 두 줄은 String 타입의 key와 Int 타입의 value를 가지는<br>
빈 딕셔너리를 생성하는 코드이다.<br>

pac10teamRankings는 값을 넣어서 초기화를 시키는 것<br>

딕셔너리 요소들을 열거하는 방법은 tuple을 이용하며 된다.<br>

```
// use a tuple with for-in to enumerate a Dictionary
for (key, value) in pac10teamRankings {
    print("\(key) = \(value)")
}
```

key는 딕셔너리 안에 있는 각각의 key가 될거고<br>
마찬가지로 value는 딕셔너리 안에 있는 각각의 value가 된다.<br>

이것도 역시나 key만 원한다면 value 자리에 언더바를 넣고<br>
value만 원한다면 key 자리에 언더바를 넣으면 된다.<br>


### 스트링 (String)
String은 Swift에서 조금 복잡하다.<br>
전부 유니코드이기 때문이다.<br>

말 그대로 전체가 유니코드라는 뜻인데<br>
전체 유니코드는 모든 종류의 언어를 지원해서<br>
하나의 문자가 정말 많은 코드가 될지도 모른다.<br>

문자 하나는 더 이상 하나의 코드가 아니라서<br>
String에 문자단위로 순서를 매길 때 Int로 나타내지 않는 이유이다.<br>
그래서 순서는 String 안에서 어떻게 움직이는지 알고 있는 index로 구성이 된다.<br>
여러 코드로 표현되는 이모지처럼 말이다.<br>

String에는 많은 멋진 메소드들이 있다.
```
startIndex -> String.Index
endIndex -> String.Index
hasPrefix(String) -> Bool
hasSuffix(String) -> Bool
lowercaseString -> String
uppercaseString -> String
```
hasPrefix는 하나의 String이<br>
다른 string의 접두사(prefix)를 가지고 있는지 아닌지를 알려준다.<br>

일괄적으로 소문자로 바꾸는 함수(lowercaseString)와<br>
일괄적으로 대문자로 바꾸는 함수(uppercaseString)도 있다.<br>
