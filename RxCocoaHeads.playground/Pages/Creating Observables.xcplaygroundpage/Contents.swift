import RxSwift

let just = Observable.just("Hello World")
just.subscribe { (event) in
    print(event)
}
/*
 next(Hello World)
 completed
 */
print("")


just.subscribe(onNext: { (next) in
    print("Next: \(next)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
})
/*
 Next: Hello World
 Completed
 */
print("")




let from = Observable.from(["Wow", "Cool", "Array"])
from.subscribe { (event) in
    print(event)
}
/*
 next(Wow)
 next(Cool)
 next(Array)
 completed
 */
print("")




enum NashvilleError: Error {
    case tourists
    case traffic
    case weather
}
let create = Observable<String>.create { (observer: AnyObserver) -> Disposable in
    observer.onNext("Nashville")
    observer.onError(NashvilleError.tourists)
    return Disposables.create()
}
create.subscribe { (event) in
    print(event)
}
/*
 next(Nashville)
 error(tourists)
 */
