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

---

## 스위프트와 파운데이션 4 : initialization

### 초기화 (Initialization)
초기화(init)이 필요할 때가 언제일까?
구조체와 클래스를 초기화하는 것에 대해서 이야기 해볼꺼야
변수 선언할 때 = 하고 값을 넣으면 되니까 그렇게 자주 필요하지 않아.
늦게 인스턴스화를 해서 처리를 할 수 있어
프로퍼티는 아마 옵셔널이 될거야
값이 할당되지 않고 그냥 시작할 수 있지
init이 필요하지 않은 많은 이유가 있어
사실 대부분의 사람들은 클래스와 구조체를 설계하려고 해
그래서 init가 필요없는거야
그냥 인자없는 init으로 쉽게 클래스와 구조체를 생성할 수 있지
아니면 데모에서 했던 것처럼 구조체 안에서
구조체 안에 있는 모든 것의 값을 초기화할 수도 있겠지
하지만 때로는 init이 필요하다는 걸 알게 될지도 몰라
그냥 이런 메커니즘을 사용해서 초기화할 수 있기 때문이지
기본으로 제공되는 init도 있어
클래스가 인자없는 init을 자동으로 생성해주었잖아
그 init으로 생성할 수 있었어
구조체가 그 안에 있는 모든 변수들을 초기화 하기위한
자동으로 생성되는 init를 가지고 있는 것도 알고 있어
이 두가지 케이스에 대해 하나 알아두어야 할 것은
만약 너만의 init을 만들기 시작했으면
자동생성 init을 사용하지 않도록 해
만약 구조체에 init을 하나라도 만든다면
더 이상 자동 생성되는 init을 가져오지 말라는거야

struct MyStruct {
    var x: Int
    var y: String
}

let foo = init(x: 5, y: "hello") // free init() method!

init의 안에서는 무엇을 할 수 있을까?
뭘 해도 되는걸까?
모든 프로퍼티의 값을 설정해 줄 수도 있고
심지어 이미 기본값을 가진 어떤 프로퍼티를 설정할 수 있어
'=' 다음에 뭔가를 할당해 주었다해도
원하면 다른 값으로 다시 설정할 수 있어
어떤 프로퍼티의 값이라도 설정할 수 있어
심지어는 상수 프로퍼티도 설정할 수 있어

let something 이 있다면
클래스 안에 상수가 있는거야

기본적으로 상수로 된 인스턴스 값처럼 말이지

상수일지라도 init 안에서 설정할 수 있어

상수로 된 프로퍼티는 매우 드물긴 해
그럼 왜 상수로 된 게 필요하냐고?
init 안에서 값이 한번 결정되면 절대 바뀌지 않는 것이 있을지도 모르잖아
너희가 만든 init에서 다른 init 메소드들을 부를 수도 있어
사실 여러 init 메소드에서 다른 init 메소드를 한개만 부를 수 있어
그리고 부모클래스의 init도 부를 수 있지
부모 클래스의 initializer 를 부를 수 있는거야
하지만 init을 부르는데 규칙이 있고 조금 복잡해

빠르게 훑어볼거고 자세한 내용은 문서로 읽어보면 돼

init 안에서 반드시 해주어야 하는 것에 대한 요구사항이 있어
이전 슬라이드에서 본 건 이렇게 해도 된다는 것들이었고
여기에는 꼭 해야만 하는 것들이야
어떤 init이 끝나면 즉, init이 끝나는 시점에는
모든 프로퍼티는 반드시 값을 가져야 해
우리는 이에 대해 잘 알고 있지
스위프트에서 초기화를 마치는 시점에는 모든 프로퍼티는 값을 가져야만 해
그리고 다시 말하지만 옵셔널도 값을 가져야해
하지만 설정되지 않은 값이 될 수도 있고 그래도 문제 없어

클래스에는 init 메소드로 두가지 타입이 있어
convenience method(편의 메소드), 아니 convenience initializers(편의 초기화함수)와 designated initializers(지정 초기화함수)가 있지
지정 이니셜라이저는 'convenience' 단어와 함께 표시되지 않아
편의 초기화함수는 convenience init 무엇무엇 이렇게 선언해
지정 초기화는 부모클래스에 있는 지정 초기화를 호출해야 해
또 그렇게만 할 수 있어
바로 위에 있는 부모 클래스로부터 말이지
지정 초기화는 부모 클래스에 있는 편의 초기화를 호출할 수 없어
또 자신의 클래스에서 부모의 편의 초기화함수를 호출할 수 없지
지정 초기화함수는 반드시
부모 클래스의 지정 초기화 함수를 호출해야 해
클래스에서 너희들이 만든 모든 프로퍼티를 초기화 해야 해
부모 클래스의 init을 부르기 전에 말야
부모 클래스가 초기화하도록 super.init을 부르기 전까지
모든 프로퍼티를 초기화 해 두어야만 해
부모클래스에 있는 어떤 프로퍼티를 건들기 전에
부모클래스의 init을 호출해야 해
순서를 알겠니?
너희 일을 하고 부모를 부른 뒤에야 프로퍼티에 접근할 수 있어
이해되지
프로퍼티에 접근하기 전에 초기화하도록 하고
너희의 초기화가 그것들이 생기기 전에 자기 일을 하길 바랄거야
편의 초기화함수는 '그 클래스 안에서' 편의 init이나 지정 init을
호출하고 초기화해야 해
또 그렇게만 할 수 있어
부모를 호출할 수는 없어
편의 초기화 함수는 부모클래스의 초기화 함수를 부를 수 없어
편의 초기화함수는 어떤 프로퍼티의 값을 설정할 수 있기 전에
반드시 그 init을 호출해야 해
자신의 클래스나 부모 클래스에 있는 것 말이지
지정 초기화는 자신의 프로퍼티를 먼저 초기화 할 수 있도록 하고
그럼 그것들이 부모를 부를거고 초기화가 될거야
편의 초기화함수가 init으로 돌아올 때까지
모든 프로퍼티의 값이 설정되고 다른 것으로 다시 설정될 수 있어
이게 바로 convenience야
다른 init을 부르는 것은 완료되어야 해
어떤 프로퍼티에 접근할 수 있기 전에 말이야
내가 말하는 건 Access(접근)이지 set(설정)이 아니야
자기 클래스에 있는 모든 프로퍼티와 메소드에 접근 할 때 말야
그래서 self 무언가로 접근할 수 없는거지
전부 초기화되기 전까지는 자기 안에 있는
어떤 프로퍼티나 메소드에 접근할 수 없는거야
다른 init을 먼저 불러야만 해

왜 편의 초기화를 사용해야하는가라고 질문했는데

지정 초기화함수의 인자에 대한 적절한 기본값이 있어
그리고 사실 스위프트에서는 기본값을 두는게 가능해
기본적으로 = 다음에 초기값을 줄 수 있는 것이지
하지만 계산되는 값으로 기본값을 두길 원한다고 해보자
아마 다른 인자에 기초하겠지
편의 초기화함순느 너희가 만든 초기화함수가
더 적은 인자를 갖도록 해주고
다시 돌아서서 지정 초기화 함수를 호출하게 해주지
말그대로 편의를 위한 것일 뿐이야
휴 규칙도 참 많고
생각해야 할 것도 많고
그리고 너희의 초기화함수를 만들기 시작하면
계속 이런 규칙을 떠올려야만 해

왠만하면 너희만의 init을 만드는 걸 피하도록 해


init을 상속하기

만약 지정 init을 어떤 것도 실행하지 않는다면
부모클래스의 모든 지정 init을 상속하게 될거야
지정 init을 하나라도 실행한다면
부모클래스에 있는 지정 init을 가져오지 않아도 돼
부모클래스의 모든 지정 init을 override하거나
그것들 중 어느것도 실행하지 않는다면
부모 클래스로부터 모든 편의 초기화 함수를 상속 받을 수 있어
다시 말해 부모 클래스의 편의 초기화 함수는
부모 클래스의 지정 초기화 함수에 전부 종속적이야
서로가 함께 연결되고 동작하고 있는 것이지
그래서 그것들을 전부 오버라이드하거나
아무것도 오버라이드 하지 않고 전부 가져와야 해
편의 초기화함수가 상속받는 것을 납득할 수 있도록 말야
초기화함수를 실행하지 않으면
부모클래스의 모든 초기화함수를 갖게 될거야
편의든 지정이든 말이지
이 규칙들에 따라 상속받은 모든 init은
전에 본 슬라이드의 규칙도 적용이 돼
클래스 안에서 편의는 지정을 호출해야 한다는 등
어쩌구 저쩌구 했던 것들 말이야
상속하게 되면 이제 너의 클래스 안에 있는거야
계속 생각해 봐야 되는 것들이지

required init(필수 초기화함수)를 보자
다른 주제야
키워드 required와 함께 init을 표시할 수 있어
자식클래스는 이 init을 반드시 실행해야 한다 뜻이야
선택적인게 아니지 꼭 그렇게 해야만 해
저기 있는 규칙을 따른다면 상속 할 수도 있어
이건 꼭 실행해야 해, 필수야
수요일날 할 UIView를 예로 들 수 있어
UIView는 required init이 있어 곧 보게 될거야

Failable initializer (실패할 수 있는 초기화함수)를 보자
실패할 수도 있는 초기화함수야
Double에서 본 적이 있지
초기화함수에 String을 넘겨줬을 때
Double이 String을 받는 초기화함수가 있을 때
String을 전달하면 Double값이 아니니까
초기화에 실패해서 nil을 반환하겠지
Failable initializer는 옵셔널 값이 반환될 수 있도록 하고
이 물음표로 명시해 줄 수 있어

init?(arg1: Type1, ...) {
    // might return nil in here
}

여기에 물음표를 넣어주면 이 초기화함수를
어떤 클래스의 옵셔널을 반환하는 초기화함수로 만들어주지
초기화가 실패하면 nil을 반환할거야
이 안에서 뭔가가 잘못되면 nil을 반환하고
nil은 여기에 접근하려는 사람에게 다시 돌어올거야
이해되니?

Failable initializer는 꽤 드물어

let image = UIImage(named: "foo") // image is an Optional UIImage (i.e. UIImage?)
Usually we would use if-let for these cases ...

image로 예를 들면 UIImage 객체로 let image가 있고
이 image는 옵셔늘 UIImage 이지
아마 여기선 if let을 사용하겠지

if let image = UIImage(named: "foo") // image is an Optional UIImage(i.e. UIImage?)

if let image = UIImage(named: "foo") {
    // image was successfully created
}
else {
    // couldn't create the image
}

if let image = UIImage(named: "foo")라고 하면
{} 안에 뭐든 해주면 되겠지

이번엔 객체를 만들기야
보통은 객체를 만들 때 적절한 인자로
초기화함수를 호출해서 만들어
타입의 이름을 사용하지

let x = CaculatorBrain()
let y = ComplicatedObject(arg1: 42, arg2: "hello", ...)
let z = [String]()

이 세가지들은 상수니까 영원히 비어있을거야
하지만 가끔은 다른 객체들이 객체를 만들어줄거야
그 객체들이 메소드를 호출해서
너희에게 객체를 만들어서 줄거야
하지만 아무런 준비없이 객체를 만들 때는
이런 표현으로 객체를 만들어주면 돼
이렇게 해왔었지 그동안
꽤 확실한 내용이었어

---

## 스위프트와 파운데이션 5 : AnyObject, Plist, NSUserDefault

### AnyObject
조금 복잡한데 이건 특별한 타입이야
실제로는 프로토콜인데 아직 공부하지 않았으니까
어쨌든 이건 특별한 타입이니까 '타입'으로 생각하면 돼
프로토콜도 타입일거야
AnyObject는 Objective-C와의 호환을 위해 사용되곤 했어
지금도 그렇게 흔히 쓰여
우리 수업중에 Objective-C 를 배우려고 할 수도 있는데
Objective-C에는 id라고 하는 매우 중요한 타입이 있어
id는 모르는 클래스의 객체에 대한 포인터 주소를 말해
그러니까 뭐든 될 수 있는 매우 열려있는 타입이곘지
스위프트에서는 그렇게 하지 않아
스위프트는 타입을 분명하게 지정해주어야 해
하지만 스위프트로도 iOS의 모든 API를 사용해야하니까
AnyObject라고 하는 타입이 도입된거야
그래서 스위프트에서 AnyObject도
모르는 클래스의 객체에 대한 포인터 주소를 뜻하겠지
클래스에 대한 객체에만 사용하지 구조체에는 사용하지 않아
Objective-C 에서의 의미는 같지
그래서 요즘에는 대신에 불투명한 타입을 사용해
객체에 대한 포인터를 갖고 싶은데 그게 무슨 타입인지 모르거나
다른 사람이 무슨 타입인지 알지 못하게 하고 싶을 때 말이지
그럼 이제 어떻게 하면 될지 이야기 해보자
클래스에만 해당되고 구조체에는 아니라고 했고
그건 그렇고 스위프트에는 Any라고 하는 타입도 있어
말 그대로 뭐든 될 수 있는거야
구조체든 클래스든
사실 우리 수업에서는 Any를 전혀 사용하지 않을거야
너희도 전혀 사용하고 싶지 않을거야
스위프트 안에 있긴 한데
내 생각엔 언어를 좀 더 완벽하게 만들기 위해 넣은 것 같긴한데
난 이걸 너희가 왜 사용해야 하는지 이유를 떠올리기 힘들어
그래서 Any는 다루지 않을거야
우리는 AnyObject에 대해선 알아볼거야
그럼 어디서 AnyObject를 보게 될까?
메소드 인자의 타입이 적어도 두개 이상 될 수 있을 때
예를 들어, 다음 수업에서 prepareForSegue 라는 걸 볼텐데
하나의 MVC로부터 다른 MVC로 화면을 전환을 준비하지
언젠가 여러개의 MVC를 만들게 될거고
한 MVC에서 다른 MVC로 전환을 할 때
prepareForSegue는 그 전환을 준비하는 메소드야
이 메소드의 sender, 그러니까 전환을 초기화하는 객체는
수많은 종류의 타입이 될 수 있잖아
클릭할 수 있는 버튼이 되거나 테이블의 한 줄이 될 수도 있고
컨트롤러 안에 커스텀한 코드가 될지도 모르는 거야
그러니까 이 sender는 AnyObject가 되어야만 해
우리는 이게 버튼일지 테이블의 한 줄일지 뭔지 모르니까
어떤 객체가 많은 타입이 될 수 있어서 무슨 타입이 될 지 모를 때
이걸 AnyObject라고 타입을 지정해주는거야
또 다른 예로는 계산기 앱에서 봤던 touchDigit 메소드야
IBaction을 만들기 위해 컨트롤 키를 누르고 코드로 끌어왔을 때
타입을 AnyObject에서 UIButton으로 바꿔준 것 기억하니?
그렇게 바꾸지 않았더라면
touchDigit의 sender를 AnyObject 타입으로 만들었을거고
touchDigit은 UIButton이나 UISlider 아니면
다른 무언가로 메시지가 보내졌을거야
우린 그렇게 하지 않았지
우린 touchDigit 안에서 sender가 UIButton이길 원했으니까
그래서 currentTitle(현재의 타이틀)같은
UIButton의 프로퍼티를 사용할 수 있었던 거야
하지만 AnyObject가 될 수도 있어
AnyObject를 사용하는 다른 예는 cookie(쿠키)를 반환하려고 할 때야
쿠키는 돌려받는 건데 누군가한테 뭔가를 주면
그들은 그 안에 뭐가 들어있는지 모르고 너도 말을 해주지 않겠지
그냥 그대로 돌려받기만 하는거야
그러니까 쿠키는 상태를 저장하고
뭔가를 기억하고 있다가 돌려주는거야
인터넷 브라우저도 쿠키가 있어서
브라우저를 통해 사이트에 들어가면
사이트는 사이트에 대한 것과 너에 대한 정보를
쿠키안에 저장하고 있다가 사이트를 나갔다가 다시 들어왔을 때
쿠키를 들여다보고 해석할거야
사이트는 브라우저에게 쿠키를 제공하지만
브라우저는 그 안에 뭐가 있는지 알 수 없어
불분명한 타입인거지
브라우저가 아는건 AnyObject라는 것일 뿐이야

그럼 AnyObject 타입을 어떻게 사용할 수 있을까?
우린 이게 무슨 타입이 될지 모르잖아
우린 우리가 아는 타입으로 변환을 해주어야 해
사실 이렇게 변환하는 건 가능하지 않을지도 모르지
변환하려고 할 떄 그 타입이 아닐 수도 있으니까
그래서 스위프트에선 as 키워드를 사용하는데
다른 타입으로 변환하는 걸 '시도' 하는 표현이야
다시 말해 AnyObject를 어떤 타입'으로서'(as) 대하겠다는거야
선택적으로 말이야
그래서 이건 옵셔널을 반환해
우린 보통 as에 if-let 구문을 사용해
as가 옵셔널을 반환하니까

```
let ao: Anyobject = ...
if let foo = ao as? SomeClass {
    // we can use foo and know that it is of type SomeClass in here
}
```

ao 라는 AnyObject 타입의 지역변수가 하나 있는데
내가 모르는 어떤 클래스(someClass)로 할당이 될거야
그렇지만 난 ao가 SomeClass라면 사용하려고 시도해 볼거야
ao는 SomeClass 일지도 모르니까 SomeClass가 맞는지 보고
맞다면 SomeClass로 사용할거야
if let foo = ao as? SomeClass {} 라고 하면
이 괄호안에는 AnyObject가 아닌 SomeClass 타입인
지역변수 foo가 들어가게 될거야
알겠니?
이정도로 간단해
기본적으로 AnyObject를 특정한 클래스로 '캐스팅' 하는거야
조건에 맞다면 말야
이게 AnyObject를 사용하는 방법이야
그렇지 않으면 그 안에 무엇이 들어있는지 모르고 전달만 하는거야
무엇을 해야할지 아는 사람에게 전달하지
쿠키라면 우리는 무엇을 해야할지 모르니까

### Property List
AnyObject를 사용하는 또 다른 곳은 Property List야
Property List는 기본적으로 Array, Dictionary, String,
Double, Int, NSData, NSDate의 조합으로 되어 있어
이 클래스들로 데이터 구조를 만들면 Property List가 생긴거야
그러니까 이건 그냥 그걸 표현하기 위한 단어일 뿐이야
하지만 너흰 의문이 생길지도 몰라
AnyObject는 구조체가 아니라 클래스로만 캐스팅 되는데
String, Array, Dictionary, Double은 구조체 잖아
그럼 어떻게 이것들이 AnyObject가 되어서
Property List에 들어갈 수 있는지 말이야
답은 '브리징'이야
이것들이 Objective-C로 자동으로 브리핑되고
자동으로 클래스인 NSDictionary, NSArray, NSNumber로 다뤄져서
AnyObject가 되도록 허락하는거야
Property List는 보이지 않게 전달 돼
그 안을 보는 사람은 Dictionary, Array, String 같은게
있다는 것만 알고 데이터가 무엇을 의미하는지는 아무것도 몰라
그냥 전달되기만 하는거야 이해하기 쉽게 Property List를 사용하는 iOS의 API를 보자

## NSUserDefault
NSUserDefault 라는게 있는데
NSUserDefault가 하는 일은 Property List를 받아서
디스크에 영구적으로 기억되게 만들어
그래서 앱을 종료했다가 다시 켜서 봐도 그대로 있는 것이지
그러니까 기본적으로 Property List의 데이터 베이스인 셈이야
Dictionary, Array, String, Date 구조체의 데이터 모음이야
이건 작은 데이터베이스이니까
영어사전같이 영어 전체를 저정해야하는 큰 데이터에 사용하지마
'설정'같은 작은 것에만 사용해
API로 간단하게 표현되는데
setObject(AnyObject, forKey: String)으로
Property List를 저장하고 다시 가져올 수도 있는거야
이렇게 '쿠키'로 저장되고 전달되는 과정을 볼 수 있을거야
NSUserDefault는 그 안에 Dictionary, Array, String이
있다는 것만 알지 구체적으로 무슨 데이터가 들었는지는 몰라
더 작게 저장하고 불러오는 것도 가능해
예를 들어 Double로 Property List를 하나 만들 수 있어
왜냐하면 Double 그 자체가 Property List이거든
Array처럼 이 클래스 들 중 하나니까
어떻게 NSUserDefault를 사용할까?
클래스 메소드 혹은 타입 메소드를 사용해서
공유해서 사용할 것을 새로 만들거야
NSUserDefault.standardUserDefualt()라고 치면
standardUserDefault의 공유되는 인스턴스를 만들 수 있어
그리고 특정한 Property List를 가져오도록 해서
데이터를 수정하게 되면 자동으로 저장이 되지만
강제로 디스크에 저장하게 하고 싶다면
Bool 값을 반환하는 동기화를 해 줄 수 있어
반환값은 우리가 거의 무시하게 될텐데
실패했을 때 무엇을 해야할지 확실하지 않기 때문이야
아마 디스크가 꽉 차서 실패하거나 할텐데
그 시점에 무엇을 해야할지 모르잖아
어쨌든 대개는 반환값을 무시하면 돼

### Casting
캐스팅에 관한 건데 캐스팅은 AnyObject에만 쓰이는 건 아냐
예를 들면, 나중에 슬라이드에서 볼 수 있겠지만
어떤 클래스의 자식 클래스가 하나 있다고 하면
as를 사용해서 캐스팅해 볼 수 있겠지
자식 클래스인지 아닌지 확실치 않은 클래스로 캐스팅할 수 있고
as가 대신 자식 클래스인지 아닌지 말해줄거야
여기 슬라이드에서 예를 들면,
ViewController의 기본 클래스인 vc가 있다고 하면
vc.displayValue 라고 할 수는 없지만
as 를 통해 캐스팅하면 다른 클래스의 자식 클래스를 사용 가능하다