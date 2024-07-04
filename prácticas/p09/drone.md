# Robot

Ejercicio pre parcial.

```smalltalk
Object subclass: #Robot
    instanceVariableNames: 'x y b'
    ...
```

```smalltalk
Robot class >> newWith: aBlock
    |r|
    r := self new.
    ^ r initWith: aBlock.
```

```smalltalk
Robot >> initWith: aBlock
    b := aBlock.
    x := 0.
    y := 0.
    ^ self.
```

```smalltalk
Robot >> avanzar
    |res|
    res := b value: x value: y.
    x := res at: 1.
    y := res at: 2.
    ^ self.
```

```smalltalk
Robot subclass: #Drone
    instanceVariableNames: 'z'
```

```smalltalk
Drone class >> newWith: aBlock
    COMPLETAR
```

```smalltalk
Drone >> init
    z := 0.
    ^ self.
```

```smalltalk
Drone >> avanzar
    COMPLETAR
```

## Solución

```smalltalk
Drone class >> newWith: aBlock
    |d|
    d := super newWith: aBlock.
    ^ d init.
```

```smalltalk
Drone >> avanzar
    (z < 10) ifTrue: [z := z + 1].
    ^ super avanzar.
```

## Seguimiento

```smalltalk
aDrone := Drone newWith: [:n1 :n2 | {n1+1 . n2+1}].
aDrone avanzar.
```

```
bloque := [:n1 :n2 | {n1+1 . n2+1}]
```

| Objeto | Mensaje | Colaboradores | Implementado en | Resultado |
|-|-|-|-|-
|`Drone`|`newWith:`|`[:n1 :n2 \| {n1+1 . n2+1}]`|`Drone`|`aDrone`|
|`Drone`|`newWith:`|`[:n1 :n2 \| {n1+1 . n2+1}]`|`Robot`|`aDrone`|
|`Drone`|`new`||`Object`|`aDrone`|
|`Drone`|`initWith:`|`[:n1 :n2 \| {n1+1 . n2+1}]`|`Robot`|`aDrone`|
|`Drone`|`init`||`Drone`|`aDrone`|
|`Drone`|`avanzar`||`Drone`|`aDrone`|
|`0`|`<`|`10`|`SmallInteger`|`true`|
|`true`|`ifTrue:`|`[z := z + 1]`|`True`|`1`|
|`0`|`+`|`1`|`SmallInteger`|`1`|
|`Drone`|`avanzar`||`Robot`|`aDrone`|
|`[:n1 :n2 \| {n1+1 . n2+1}]`|`value:value:`|`0`, `0`|`BlockClosure`|`#(1 1)`|
|`0`|`+`|`1`|`SmallInteger`|`1`|
|`0`|`+`|`1`|`SmallInteger`|`1`|
|`#(1 1)`|`at:`|`1`|`OrderedCollection`|`1`|
|`#(1 1)`|`at:`|`2`|`OrderedCollection`|`1`|
