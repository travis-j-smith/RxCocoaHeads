import RxSwift

let observable = Observable.from([1, 2, 3])

print("Map example...")

let mappedObservable = observable.map({ "\($0 * 10)"})

mappedObservable.subscribe { (event) in
    print(event)
}
/*
 next(10)
 next(20)
 next(30)
 completed
 */
print("")




print("FlatMap example...")

let flatMappedObservable = observable.flatMap({ Observable.from([$0 * 5, $0 * 7, $0 * 11])})

flatMappedObservable.subscribe { (event) in
    print(event)
}
/*
 next(5)
 next(7)
 next(10)
 next(11)
 next(14)
 next(15)
 next(22)
 next(21)
 next(33)
 completed
 */
print("")



print("FlatMapLatest example...")
let flatMapLatestObservable = observable.flatMapLatest({ Observable.from([$0 * 5, $0 * 7, $0 * 11])})

flatMapLatestObservable.subscribe { (event) in
    print(event)
}
/*
 next(5)
 next(10)
 next(15)
 next(21)
 next(33)
 completed
 */
print("")




print("Merge example...")

let preMerge1 = Observable.from(["Uno", "Dos", "Tres"])
let preMerge2 = Observable.from(["One", "Two", "Three"])
let merged = Observable.merge(preMerge1, preMerge2)
merged.subscribe { (event) in
    print(event)
}
/*
 next(Uno)
 next(One)
 next(Dos)
 next(Two)
 next(Tres)
 next(Three)
 completed
 */
print("")




print("Zip example...")

let intsObservable = Observable.from([100, 200, 300, 400])
let stringsObservable = Observable.from(["Cocoa", "Heads"])
let zipped = Observable.zip(intsObservable, stringsObservable) { (int, string) -> String in
    return "\(int)\(string)"
}
zipped.subscribe { (event) in
    print(event)
}
