import RxSwift

print("Without sharing...")

let intsObservable = Observable<Int>.create { (observer) -> Disposable in
    observer.onNext(1)
    observer.onNext(2)
    observer.onNext(3)
    return Disposables.create {
        print("Disposing observable...")
    }
}

intsObservable.subscribe(onNext: { (int) in
    print("Next: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed")
})
/*
 Next: 1
 Next: 2
 Next: 3
 */
print("")

intsObservable.subscribe(onNext: { (int) in
    print("Next: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed")
})
/*
 Next: 1
 Next: 2
 Next: 3
 */
print("")




print("With sharing...")

let sharedIntsObservable = intsObservable.share(replay: 1)
let disposable1 = sharedIntsObservable.subscribe(onNext: { (int) in
    print("Next: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed 1")
})
/*
 Next: 1
 Next: 2
 Next: 3
 */
print("")

let disposable2 = sharedIntsObservable.subscribe(onNext: { (int) in
    print("Next: \(int)")
}, onError: { (error) in
    print("Error: \(error)")
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed 2")
})
/*
 Next: 3
 */
print("")

disposable1.dispose()
disposable2.dispose()
/*
 Disposed 1
 Disposing observable...
 Disposed 2
 */
