import RxSwift

let single = Single<Int>.create { (event: (SingleEvent<Int>) -> Void) -> Disposable in
    event(.success(3))
    return Disposables.create()
}
single.subscribe(onSuccess: { (int) in
    print("Success: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
})
/*
 Success: 3
 */
print("")




enum MyError: Error {
    case oops
}
let badSingle = Single<String>.create { (event: (SingleEvent<String>) -> Void) -> Disposable in
    event(.success("Oh"))
    event(.success("No"))
    event(.error(MyError.oops))
    
    return Disposables.create()
}
badSingle.subscribe(onSuccess: { (int) in
    print("Success: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
})
/*
 Success: Oh
 */
print("")




let completable = Completable.create { (event: (CompletableEvent) -> Void) -> Disposable in
    event(.completed)
    return Disposables.create()
}
completable.subscribe(onCompleted: {
    print("Completed")
}, onError: { (error) in
    print("Error: \(error)")
})
/*
 Completed
 */
print("")




let maybe = Maybe<CGRect>.create { (event: (MaybeEvent<CGRect>) -> Void) -> Disposable in
    event(.error(MyError.oops))
    return Disposables.create()
}
maybe.subscribe(onSuccess: { (rect) in
    print("Success: \(rect)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
})
/*
 Error: oops
 */
print("")


let badMaybe = Maybe<CGRect>.create { (event: (MaybeEvent<CGRect>) -> Void) -> Disposable in
    event(.success(.zero))
    event(.error(MyError.oops))
    return Disposables.create()
}
badMaybe.subscribe(onSuccess: { (rect) in
    print("Success: \(rect)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
})
/*
 Success: (0.0, 0.0, 0.0, 0.0)
 */
print("")
