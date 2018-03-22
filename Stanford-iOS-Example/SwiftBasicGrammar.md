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
let (word, number, value) = x // 위에 생성한 튜플을 word, number, value 라는 이름에 할당
print(word)     // prints hello
print(number)   // prints 5
print(value)    // prints 0.85
```

```
let x: (w: String, i: Int, v: Double) = ("hello", 5, 0.85) // 튜플 생성하면서 각 w, i, v에게 할당
print(x.w) // prints hello
print(x.i) // prints 5
print(x.v) // prints 0.85
```

```
func getSize() -> Double { return  } // 이렇게 함수 뒤에 반환 타입을 적지만 반환 타입을 아래와 같이 튜플로 적어도 됨
func getSize() -> (weight: Double, height: Double) { return (250, 80) } // 함수 뒤에 반환 할 타입을 적어야 하는데 튜플도 타입 중 하나이기 때문에 위와 같이 사용 가능

let x = getSize()
print("weight is \(x.weight)") // weight is 250
print("height is \(getSize().height)") // height is 80
```

튜플은 완벽하게 유효한 반환 타입이 될 수 있으며 여러 개의 값을 반환할 수 있다.

---

### Range
무엇이든 연속적으로 표현될 수 있는 것의 양 끝 점을 가르킨다.
Range는 Array처럼 일반화 된 타입이기 떄문에
Int로 된 Range나 무언가의 인덱스로 된 Range도 될 수 있다.

```
struct Range<T> {
    var startIndex: T
    var endIndex: T
}
```

```
let array = ["a", "b", "c", "d"]
let subArray1 = array[2...3]    // subArray1 will be ["c", "d"]
let subArray2 = array[2..<3]    // subArray2 will be ["c"]
for i in 27...104 { }           // Range is enumeratable, like Array, String, Dictionary
```

---

### Data Structures in Swift
Class, Struct, Enum 3개의 유사점과 차이점

유사점
- 모두 똑같은 방법으로 선언이 된다.
(키워도 + 이름 + {} 구조)
- 모두 프로퍼티와 함수를 가질 수 있다.
(다만 enum은 저장 프로퍼티를 가질 수 없지만 계산 프로퍼티는 가질 수 있다. enum이 기억하고 있는 저장소는 case였고 case와 연관값이 있었다.)
- Initializer(초기화 함수)를 가질 수 있다.
(enum만 제외하고 초기화 함수를 가지도록 되어있다. enum은 초기화 함수를 가질 필요가 없다. 연관값을 구별되는 값들에 할당해주기 때문이다.)

차이점
- 클래스에서는 상속을 할 수 있지만, 주
- struct와 enum은 값으로 전달되는 값 타입, 클래스는 참조 타입으로 포인터(메모리 주소)로 전달되고 힙(동적으로 할당되는 메모리 영역) 메모리에 있다.
(값 타입은 함수에서 인자로 전달될 때 복사되고, 다른 변수에 할당할 떄도 복사한다.
값 타입 개념은 let 변수에 할당한 경우 값을 바꿀 수 없다.
Array가 하나 있다면 Array는 구조체니까 값 타입이다.
이걸 let 변수에 할당하면, let x = array 이렇게 그 배열에는 다른 것을 추가할 수 없다.
바꿀 수 없으니까.
Dictionary 같은 것도 마찬가지.
함수의 모든 인자는 상수였음. 물론 그 안으로 복사하고 값을 바꿀 수도 있다
왜냐하면 복사 개념이 작동하는 방식때문에 구조체나 enum을 가지고 있으면 스위프트는 모든 함수에 구조체나 enum이 바뀔지도 모른다고 표시를 하게 만들어.
바뀌는 함수라고 해서 mutating이라는 키워드를 사용하지. mutating func 처럼 말야.
그 함수가 구조체를 바꿀 수 있는 경우가 되겠지.
그 이유는 스위프트가 복사를 하려고 할 때는 실제로 복사를 하고 싶어하지 않아.
다른 포인터를 갖고 있다가 값이 바뀌려고 하자마자 그 때 복사가 되는거야.
성능 향상을 위한 절차이지.
그래서 구조체의 값을 바꾸는 함수가 있는 구조체가 있다면 스위프트가 알 수 있도록 mutating을 붙여줘야 해)
- 참조타입
(힙 메모리에 저장되어 있다가 참조를 줬지.
그 참조는 자동으로 카운트 된다.
그 말은 스위프트에는 Garbage Collection[메모리 관리 기법 중의 하나로 프로그램이 동적으로 할당했던 메모리 영역 중에서 필요 없게 된 영역을 해제하는 기능]이 없다는 걸 뜻한다.
힙 메모리에 기록되고 지워진다.
힙에 있는 무언가에 새로운 포인터를 생성할 때마다 스위프트가 알아서 추적하고 카운트 한다.
그러다가 카운트가 0이 되면, 예를 들어 마지막으로 참조하던 포인터가 영역을 벗어났다던가
마지막 포인터를 다른 걸 가리키기 위해 할당했다던지 해서 아무것도 가리키는게 없어지면 즉시 힙 메모리에서 제거 되지 예정대로 즉시 힙에서 사라진다.
Garbage Collection과는 매우 다르다. 가비지 컬렉션은 뒤에서 무슨 일이 일어나고 있는지 보고 있다가 오랫동안 힙 메모리에 머물고 있는 녀석들을 한꺼번에 수집해야 했었지
이건 예측가능한 메모리 관리이고 우리를 위해 알아서 해줄거야. 이 과정에 유일하게 참여할 수 있는 방법이 weak와 strong이야.
클래스에 상수 포인터가 있다면 분명히 포인터이니까 여전히 바꿀 수 있어
구조체인 경우 var y = x 에서 y에 무언가를 더해주어도 x값이 바뀌지 않겠지만 똑같이 var y = x 인데 x가 클래스라면 y에게 메시지를 보내면 x에게도 보내지는 거야
같은 것이니까. 힙 메모리에 동일한 포인터로 있고 복사를 하지 않으니까 그래서 모든 let의 뜻은 포인터가 변하지 않을 것이란 말이야
포인터가 가리키는 것이 변하지 않는다는 의미가 아니란 거야.
분명하게도 포인터를 인자로써 클래스에 전달하면 복사하지 않고 포인터를 전달해)

반면 구조체는 좀 더 근본적인 타입으로 사용 될거야 String, Double, Int, Array, Dictionary 같은 타입이나 또 그림을 그리기 위한 점, 직사각형
클래스보다는 더 작고 스스로 자립하며 값으로 복사되는게 말이 되고 값 타입을 원하는 영역들 그게 바로 구조체를 선택하는 주요 이유야
전달을 하고 다닐 때 값 개념을 원하게 되는 상황인거지
그렇지 않다면 클래스를 선택하면 돼
뭐든 큰 것은 거의 확실히 클래스를 사용하게 될 거야