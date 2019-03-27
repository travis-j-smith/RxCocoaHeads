import RxSwift

print("PublishSubject example...")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("Too Early")

publishSubject.subscribe { (event) in
    print(event)
}

publishSubject.onNext("Hello")
publishSubject.onNext("World")
publishSubject.onCompleted()
publishSubject.onNext("Too Late")
/*
 next(Hello)
 next(World)
 completed
 */
print("")




print("BehaviorSubject example...")

let behaviorSubject = BehaviorSubject<Int>(value: 100)

behaviorSubject.onNext(200)

behaviorSubject.subscribe { (event) in
    print(event)
}

behaviorSubject.onNext(400)
behaviorSubject.onCompleted()
behaviorSubject.onNext(0)
/*
 next(200)
 next(400)
 completed
 */
