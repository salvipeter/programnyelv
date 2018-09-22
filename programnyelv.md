Egy programnyelv felépítése
===========================
*Salvi Péter, 2018*

Ebben a dokumentumban egy egyszerű funkcionális programnyelv készítését mutatom be kombinatorikus logikai alapokon. Nem törekedtem matematikai precizitásra, csak a felépítés elvét akartam megmutatni; a bibliográfiában található könyvek jó kiindulási alapot adnak az érdeklődő olvasó számára.

Kombinátorok
============

Definiáljuk a `K` és `S` kombinátorokat:

    Kab  = a
    Sabc = Sac(bc)

Itt a kis `a`, `b`, `c` stb. betűk tetszőleges kifejezéseket jelentenek. Ahol nincsen külön jelezve, ott a zárójelezés balról történik, tehát `abcd=((ab)c)d`. A fenti egyenlőségek értelme az, hogy a két oldalon található kifejezések felcserélhetőek.

Hasznos kombinátorok
--------------------

Elsőként nézzük meg, mire egyszerűsíthető az `SKKa` kifejezés!

    SKab = Kb(ab)
         = b

Ez az identitás kombinátor, amire a továbbiakban az `I:=SKK` jelölést fogjuk használni, tehát `Ia=a`.

Egy másik fontos, ún. *kompozíciós* kombinátor a `B:=S(KS)K`:

    Babc = S(KS)Kabc
         = KSa(Ka)bc
         = S(Ka)bc
         = Kac(bc)
         = a(bc)

Szintén hasznos a `C:=S(BS(BKS))(KK)` cserélő kombinátor:

    Cabc = S(BS(BKS))(KK)abc
         = BS(BKS)a(KKa)bc
         = S(BKSa)(KKa)bc
         = BKSab(KKab)c
         = K(Sa)b(KKab)c
         = Sa(KKab)c
         = ac(KKabc)
         = ac(Kbc)
         = acb

Fixpont-kombinátor
------------------

A fenti kombinátorok segítségével felírható a fixpont-kombinátor:

    Y := S(CB(SII))(CB(SII))

Nézzük meg, milyen hatással van az argumentumára:

    Ya = S(CB(SII))(CB(SII))a
       = CB(SII)a(CB(SII)a)
       = Ba(SII)(CB(SII)a)
       = a(SII(CB(SII)a))
       = a(I(CB(SII)a)(I(CB(SII)a)))
       = a((CB(SII)a)(I(CB(SII)a)))
       = a(CB(SII)a(CB(SII)a)
       = a(Ya)

Ezt majd a rekurziónál fogjuk használni.

A kombinátorok képzése
----------------------
Az `S` és `K` kombinátorok *bázist* alkotnak, tehát minden más kombinátor kifejezhető velük. Más kombinátorok `S`,`K`-alakra való átalakítását egy speciális számítógép gépi kódjára való fordításaként is felfoghatjuk.

Egy többargumentumú kombinátor lefordítását úgy tehetjük meg, hogy az utolsó kivételével minden argumentumot konstansnak tekintünk, tehát pl. a `Wab=abba` kombinátor elkészítéséhez először egy `Vb=abba` operátort hozunk létre, amelyben az `a`-k konstansok. Ezt a `V:=C(SaI)a` kifejezés oldja meg (hogy ehhez hogyan jutottunk el, kiderül később):

    Vb = C(SaI)ab
       = SaIba
       = ab(Ib)a
       = abba

Ezután definiálunk egy `U` kombinátort úgy, hogy `Ua=V=C(SaI)a` teljesül - ezt az `S(BC(CSI))I` kifejezés oldja meg:

    Uab = S(BC(CSI))Iab
        = BC(CSI)a(Ia)b
        = C(CSIa)(Ia)b
        = CSIab(Ia)
        = SaIb(Ia)
        = ab(Ib)(Ia)
        = abb(Ia)
        = abba

Hogy ne kelljen mindig új kombinátornevekkel dolgozni, és könnyen le lehessen írni a kombinátorképzés módszerét, vezessük be a következő jelölést: `[Lx.a]` jelentse azt a kombinátoros kifejezést, amelyre igaz, hogy az `[Lx.e]a`-ből levezethető az `ê`, ami az `e` kifejezésnek egy olyan változata, amelyben minden `x`-et `a`-ra cseréltünk. Például `[Lx.axxa]=V=C(SaI)a`, mivel `Vb=abba`.

Most már készen állunk arra, hogy megnézzük a fordítás egyes eseteit:

1. `[Lx.a]  = Ka` amikor `a` nem tartalmazza `x`-et
2. `[Lx.x]  = I`
3. `[Lx.ab] = S[Lx.a][Lx.b]`

Ebből az első kettő triviális, hiszen `[Lx.a]b=Kab=a`, illetve `[Lx.x]a=Ia=a`, de a harmadik esetet érdemes közelebbről megvizsgálni:

    [Lx.ab]c = S[Lx.a][Lx.b]c
             = [Lx.a]c([Lx.b]c)
             = ([Lx.a]c)([Lx.b]c)

Tehát egy `ab` alakú kifejezésben úgy tudjuk behelyettesíteni az `x` helyére a `c`-t, hogy ezt elvégezzük mind az `a`, mind a `b` részkifejezésre, és ezeket egymás mellé tesszük. Ez a rekurzív definíció értelmes, mivel az alapesetet, amikor az `a` vagy `b` kifejezések már nem bonthatóak tovább, az első két pont már lekezelte.

Példaként térjünk vissza megint a `V` kombinátorhoz:

    [Lx.axxa] = S[Lx.axx][Lx.a]
              = S(S[Lx.ax][Lx.x])[Lx.a]
              = S(S(S[Lx.a][Lx.x])[Lx.x])[Lx.a]
              = S(S(S(Ka)[Lx.x])[Lx.x])[Lx.a]
              = S(S(S(Ka)I)[Lx.x])[Lx.a]
              = S(S(S(Ka)I)I)[Lx.a]
              = S(S(S(Ka)I)I)(Ka)

A kifejezés tovább egyszerűsíthető az alábbi (könnyen igazolható) egyenlőségek használatával:

1. `S(Ka)I    = a`
2. `S(Ka)(Kb) = K(ab)`
3. `S(Ka)b    = Bab`
4. `Sa(Kb)    = Cab`

Jelen esetben az 1. és 4. egyenlet miatt `[Lx.axxa] = S(SaI)(Ka) = C(SaI)a`.

A továbbiakban az `[Lx.[Ly.e]]` helyett az `[Lxy.e]` jelölést használjuk (és hasonlóan `[Lxyz.e]` stb.), pl. `[Lxy.xyyx]=S(BC(CSI))I`.

Egypontos bázisok
-----------------

Érdekes, hogy az `S` és `K` kifejezhetőek egyetlen kombinátorral is, amit így definiálhatunk:

    Xa = aKSK

Ekkor a `K` levezetése:
        
    XXX = XKSKX
        = KKSKSKX
        = KKSKX
        = KKX
        = K

Az `S` levezetése pedig:

    X(XX) = XXKSK
          = XKSKKSK
          = KKSKSKKSK
          = KKSKKSK
          = KKKSK
          = KSK
          = S

Más egyedüli kombinátorral (*bázissal*) is elkészíthető az `S` és `K`, pl. legyen
       
    Za = aSK

A `K` levezetése kicsit hosszabb:

    Z(Z(ZZ)) = Z(Z(ZSK))
             = Z(Z(SSKK))
             = Z(Z(SK(KK)))
             = Z(SK(KK))SK
             = SK(KK)SKSK
             = KS(KKS)KSK
             = SKSK
             = KK(SK)
             = K

Az `S`-é viszont annál rövidebb:

    Z(Z(Z(ZZ))) = ZK = KSK = S

(Itt érdemes azonban megjegyezni, hogy mivel az `S` és `K` tulajdonságait felhasználtuk a levezetésekben, az nem igaz, hogy az `Xa=a(XXX)(X(XX))(XXX)` ill. `Za=a(Z(Z(Z(ZZ))))(Z(Z(ZZ)))` képletekből minden levezethető lenne.)

Lambda-kalkulus
===============
Egy lambda-kifejezés a következők egyike:

- egy változó (`x`, `y`, ...)
- `(λx.M)`, ahol `x` változó, `M` pedig egy lambda-kifejezés
- `(MN)`, ahol `M` és `N` lambda-kifejezések.

A zárójeleket, ahol egyértelmű, itt is elhagyjuk, és `λx.(λy.M)` helyett a `λxy.M` alakot használjuk.

A lambda-kifejezéseken értelmezett az ún. β-redukció:

    (λx.M)a = M[x:=a],

ahol `M[x:=a]` megegyezik az `M`-mel, de az `x` változó összes előfordulása helyett `a` szerepel benne. Itt feltételezzük, hogy az `M`-en belüli, `λ`-val deklarált `x` nevű változókat átnevezzük, pl.

    (λx.x(λx.yx))a = (x(λx.yx))[x:=a]
                   = (x(λz.yz))[x:=a]
                   = x(λz.yz)

A `(λx.M)` egy egyváltozós függvénynek felel meg, az `(MN)` kifejezés pedig a függvényapplikációnak, tehát pl. az `f(x)=2*x+1` függvény lambda-kifejezésként így írható fel:

    λx.+(*2x)1

(Feltételezvén a számok és a számok közti műveletek megfelelő definícióját, ld. később.)

A megfeleltetés a lambda-kalkulus és a kombinatorikus logika között nagyon egyszerű:

    x      → x
    (λx.M) → [Lx.M]
    (MN)   → (MN)

A továbbiakban áttérünk a LISP programnyelv-féle jelölésre:

    x      → x
    (λx.M) → (lambda (x) M)
    (MN)   → (M N)

A zárójeleket itt mindig megtartjuk, a többargumentumú függvényeknél pedig az argumentumokat szóközzel választjuk el, pl.:

    (λxy.xyyz) → (lambda (x y) (((x y) y) z))

Párok
=====

Az igaz és hamis értékeket a következő módon definiálhatjuk:

    T := (lambda (x y) x)
    F := (lambda (x y) y)

Ezzel a definícióval a predikátumok egyben elágazásként is használhatóak. Ha `p` értéke `T` vagy `F`, akkor `(p a b)` a `p` igazságértéke szerint választ az `a` és `b` kifejezések közül. Erre az átláthatóság kedvéért az `if` jelölést vezetjük be:

    if := (lambda (p a b) (p a b))

Az igazságértékeken végzett műveletek is könnyen definiálhatóak, pl.:

    not := (lambda (p) (if p F T))
    and := (lambda (p q) (if p q F))
    or  := (lambda (p q) (if p T q))

Hasonló trükkel adatszerkezeteket is definiálhatunk. A

    cons := (lambda (m n) (lambda (z) (z m n)))
    
függvény egy, az `m` és `n` kifejezéseket tartalmazó párként fogható fel. A két tagot a

    car := (lambda (p) (p T))
    cdr := (lambda (p) (p F))

függvényekkel lehet lekérdezni. Ellenőrzésképpen:

    (car (cons x y)) = (car ((lambda (m n) (lambda (z) (z m n))) x y))
                     = (car (lambda (z) (z x y)))
                     = ((lambda (p) (p T)) (lambda (z) (z x y)))
                     = ((lambda (z) (z x y)) T)
                     = (T x y)
                     = x

Számok
======

Definiáljuk a természetes számokat! Legyen

    0 := (lambda (x) x)
    1 := (cons F 0)
    2 := (cons F 1)
    ...

Ekkor az egyet hozzáadó ill. levonó függvények nyilvánvalóan

    +1 := (lambda (n) (cons F n))
    -1 := cdr

Érdemes megfigyelni, hogy `(-1 0)=F`. Egy számról a

    zerop := car
    
függvény dönti el, hogy `0`-e (`0`-ra `T`, más számra `F`).

Az összeadáshoz, szorzáshoz már rekurzió kell, ezekre majd később visszatérünk.

Változók
========

Vezessük be a

    ((lambda (x) (+1 x)) 1) = (+1 x)[x := 1]

kifejezésre az alábbi jelölést:

    (let ((x 1))
      (+1 x))

Több argumentum esetén

    ((lambda (x y) (cons x (cons y 3))) 1 2) = (cons x (cons y 3))[x := 1, y := 2]
    
helyett azt írjuk, hogy

    (let ((x 1)
          (y 2))
      (cons x (cons y 3)))

Ez a jelölés jobban mutatja, hogy mi történik: lokális változókat definiálunk, amelyeket aztán a `let` *blokk* belsejében felhasználunk.

Rekurzió
========

Rekurzióhoz, tehát hogy egy függvény önmagára tudjon hivatkozni, az `Y` fixpont-kombinátort fogjuk használni. Az aktuális jelöléseinkkel ez

    Y := (lambda (f)
           (let ((g (lambda (x) (f (x x)))))
             (g g)))

Ellenőrzés:

    (Y f) = ((lambda (x) (f (x x))) (lambda (x) (f (x x))))
          = (f ((lambda (x) (f (x x))) (lambda (x) (f (x x)))))
          = (f (Y f))

Példaként definiáljuk az összeadást:

    plus := (lambda (f)
              (lambda (x y)
                (if (zerop x)
                    y
                    (f (-1 x) (+1 y)))))
    +    := (Y plus)

Nézzük meg, ez mit csinál!

    (+ a b) = ((Y plus) a b)
            = ((plus (Y plus)) a b)
            = ((lambda (x y)
                 (if (zerop x)
                     y
                     ((Y plus) (-1 x) (+1 y))))
               a b)
            = (if (zerop a)
                  b
                  ((Y plus) (-1 a) (+1 b)))
            = (if (zerop a)
                  b
                  ((plus (Y plus)) (-1 a) (+1 b)))
            = ...

Innen már látszik, hogy beindul a rekurzió. Azonban az is látszik, hogy ahhoz, hogy ez működjön, jól kell megválasztani, hogy mit fejtünki ki, ugyanis pl. megtehetnénk, hogy folyton csak az `Y` definícióját alkalmazzuk, és ez a levezetés sosem fog leállni.

Lusta és szigorú kiértékelés
----------------------------

Az `Y` fenti definíciója csak ún. *lusta kiértékelés* esetén működik, amikor egy-egy kifejezést csak akkor értékelünk ki, amikor már fel akarjuk használni. A *szigorú kiértékelesnél* azonban egy függvény kiértékelése előtt először mindig kiértékeljük az összes argumentumot. Szerencsére emellett a kiértékelési mód mellett is adható egy működő definíció az `Y` kombinátorra:

    Y := (lambda (f)
           ((lambda (x) (f (lambda (y) ((x x) y))))
            (lambda (x) (f (lambda (y) ((x x) y))))))

Ellenőrizzük:

    (Y f) = ((lambda (x) (f (lambda (y) ((x x) y))))
             (lambda (x) (f (lambda (y) ((x x) y))))))
          = (f (lambda (y)
                 (((lambda (x) (f (lambda (y) ((x x) y))))
                   (lambda (x) (f (lambda (y) ((x x) y)))))
                  y)))
          = (f (lambda (y) ((Y f) y)))

A trükk tehát az, hogy egy belső `lambda`-val késlelteti a kiértékelést. Ennek a belső  `lambda`-nak annyi paramétere kell legyen, mint a rekurzív függvénynek.

Példaként nézzük meg az új `Y` kombinátorral a fenti levezetést:

    (+ a b) = ((Y plus) a b)
            = ((plus (lambda (y1 y2) ((Y plus) y1 y2))) a b)
            = ((lambda (x y)
                 (if (zerop x)
                     y
                     ((lambda (y1 y2) ((Y plus) y1 y2)) (-1 x) (+1 y))))
               a b)
            = (if (zerop a)
                  b
                  ((lambda (y1 y2) ((Y plus) y1 y2)) (-1 a) (+1 b)))
            = (if (zerop a)
                  b
                  ((Y plus) (-1 a) (+1 b)))
            = (if (zerop a)
                  b
                  ((plus (lambda (y1 y2) ((Y plus) y1 y2))) (-1 a) (+1 b)))

Innen megint látszik már a rekurzió, és ezúttal nem lehetett végtelen a kiértékelés... vagy mégis? A szemfüles olvasó biztosan észrevette, hogy ahhoz, hogy ez jól működjön, az `if` kiértékelése lusta kell legyen, tehát csak az elágazási feltételnek megfelelő ágat szabad kiértékelje.

További példák
--------------

Az egyszerűség kedvéért a rekurzív függvényeknél az `Y` kombinátort nem fogjuk explicit módon kiírni, hanem a függvény saját nevére való hivatkozás fogja implicit jelezni, pl.:

    + := (lambda (x y)
           (if (zerop x)
               y
               (+ (-1 x) (+1 y))))

És:

    = := (lambda (x y)
           (or (and (zerop x) (zerop y))
               (and (not (zerop x))
                    (and (not (zerop y))
                         (= (-1 x) (-1 y))))))

A `let`-tel definiált változókban is alkalmazhatunk rekurzív függvényeket, pl.:

    (let ((fact (lambda (n)
                  (if (zerop n)
                      1
                      (* n (fact (-1 n)))))))
      (fact 10))

A szorzás definíciójában ki is használjuk ezt:

    * := (lambda (x y)
           (let ((rec (lambda (n result)
                        (if (zerop n)
                            result
                            (rec (-1 n) (+ result y))))))
             (rec x 0)))

Hogyan tovább?
==============

Érdemes bevezetni a

    (define (foo x y) <...>) = (let ((foo (lambda (x y) <...>))) ... )
    (define bar z)           = (let ((bar z)) ... )

jelölést egy képzeletbeli, az egész programunkat körülölelő külső `let`-ben való definíciókra. Ezzel globális változókat ill. függvényeket tudunk készíteni.

A párok láncolásából listát készíthetünk, valamilyen jól megkülönböztethető záróelemmel:

    (cons x (cons y (cons z . NIL))) ~ [x,y,z]

Egy logikus következő lépés a típusok hozzáadása. Erre egy egyszerű módszer, hogy kizárólag párokkal dolgozunk, és a párok első eleme egy szám, ami a típust reprezentálja (pl. 0 = NIL, 1 = igazságérték, 2 = természetes szám, 3 = egész szám, 4 = valós szám, 5 = karakter, 6 = pár, 7 = függvény stb.), a második pedig a tényleges adat. Minden típushoz lehet rendelni felismerő-függvényt, pl.:

    (define (naturalp n) (= (car n) 2))

A típusos számok szorzására definiálható a

    (define (nat* x y) (cons 2 (* (cdr x) (cdr y))))

függvény stb. Típusellenőrzésekre is szükség lesz.

Végül lehetne metaprogramozást beletenni: olyan függvényeket, melyek eredménye egy függvény definíciója...

Bibliográfia
============

1. Ch. Hankin, *An Introduction to Lambda Calculi for Computer Scientists*, King's College Publications, 2004.
2. J. R. Hindley, J. P. Seldin, *Lambda-Calculus and Combinators - An Introduction*, Cambridge University Press, 2008.
3. H. Abelson, G. J. Sussman, *Structure and Interpretation of Computer Programs*, MIT Press, 1996.
4. S. P. Jones, *The Implementation of Functional Programming Languages*, Prentice Hall, 1987.
5. C. Queinnec, *Lisp in Small Pieces*, Cambridge University Press, 2003.
