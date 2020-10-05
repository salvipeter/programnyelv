




           Egy programnyelv felépítése

         kombinatorikus logikai alapokon




                  Salvi Péter

                  2020.10.14.




--------------------------------------------------


Tartalom

1. Bevezetés a kombinatorikus logikába
   - Egyszerű kombinátorok
   - Fixpont kombinátor
   - Kombinátorok képzése
   - Egypontos bázisok
2. Lambda-kalkulus
   - Kapcsolat a kombinátorokkal
3. Nyelvi elemek
   - Logikai műveletek
   - Párok
   - Számok
   - Változók
   - Rekurzió
   - Lusta & szigorú kiértékelés
4. Hogyan tovább?


Kombinatorikus logika
  [Schönfinkel, 1924 / Curry, 1927]

    <exp> ::= K | S | (<exp><exp>)

Egyszerűsített zárójelezés:

    (((SS)K)S)             => SSKS
    ((K(SK))S)             => K(SK)S
    (((K(SS))((K(SK))K))K) => K(SS)(K(SK)K)K

Kombinátor szabályok:

    Kab  = a
    Sabc = ac(bc)



Hasznos kombinátorok

    SKab = Kb(ab) = b

=> Identitás kombinátor `I := SKK` => `Ia = a`

    S(KS)Kabc = KSa(Ka)bc =
      S(Ka)bc = Kac(bc)   = a(bc)

=> Kompozíciós kombinátor `B := S(KS)K`

    S(BS(BKS))(KK)abc = BS(BKS)a(KKa)bc =
       S(BKSa)(KKa)bc = BKSab(KKab)c    =
       K(Sa)b(KKab)c  = Sa(KKab)c       =
       ac(KKabc)      = ac(Kbc) = acb

=> Cserélő kombinátor `C := S(BS(BKS))(KK)`


Fixpont kombinátor

    Y := S(CB(SII))(CB(SII))

Ebből:

    Ya = S(CB(SII))(CB(SII))a
       = CB(SII)a(CB(SII)a)
       = Ba(SII)(CB(SII)a)
       = a(SII(CB(SII)a))
       = a(I(CB(SII)a)(I(CB(SII)a)))
       = a((CB(SII)a)(I(CB(SII)a)))
       = a(CB(SII)a(CB(SII)a))
       = a(Ya)


Kombinátorok képzése I

- `S` és `K` bázis, minden más kifejezhető
- az `SK` bázisra alakítás egy fajta "fordítás"
- többargumentumú kombinátor =>
    vegyük az utolsó kivételével "konstansnak"

Pl. `Tab = abba` kombinátorhoz először `Ub = abba`

    U := C(SaI)a
    Ub = C(SaI)ab = SaIba = ab(Ib)a = abba

Ezután `Va = U = C(SaI)a` kombinátort keresünk

    V := S(BC(CSI))I
    Vab = S(BC(CSI))Iab = BC(CSI)a(Ia)b
        = C(CSIa)(Ia)b  = CSIab(Ia) = SaIb(Ia)
        = ab(Ib)(Ia)    = abb(Ia)   = abba


Kombinátorok képzése II - szabályok

Jelölés: `[Lx.a]`
- `[Lx.e]a`-ból levezethető egy `ê` kifejezés,
  ami az `e` egy változata, de `x`-ek helyett `a`
- Pl. `[Lx.axxa] = U = C(SaI)a`, mivel `Ub = abba`

A fordítás esetei:

1. `[Lx.a]  = Ka` amikor `a`-ban nincs `x`
2. `[Lx.x]  = I`
3. `[Lx.ab] = S[Lx.a][Lx.b]`

A 3-as bizonyítása:

    [Lx.ab]c = S[Lx.a][Lx.b]c
             = [Lx.a]c([Lx.b]c)
             = ([Lx.a]c)([Lx.b]c)


Kombinátorok képzése III - példa & egyszerűsítés

    [Lx.axxa] = S[Lx.axx][Lx.a]
              = S(S[Lx.ax][Lx.x])[Lx.a]
              = S(S(S[Lx.a][Lx.x])[Lx.x])[Lx.a]
              = S(S(S(Ka)[Lx.x])[Lx.x])[Lx.a]
              = S(S(S(Ka)I)[Lx.x])[Lx.a]
              = S(S(S(Ka)I)I)[Lx.a]
              = S(S(S(Ka)I)I)(Ka)

1. `S(Ka)I    = a`
2. `S(Ka)(Kb) = K(ab)`
3. `S(Ka)b    = Bab`
4. `Sa(Kb)    = Cab`

=> (1, 4) => `[Lx.axxa] = S(SaI)(Ka) = C(SaI)a`

Jelölés: `[Lx.[Ly.e]]` => `[Lxy.e]`
- pl. `[Lxy.xyyx] = S(BC(CSI))I`


Egypontos bázisok

Az `Xa = aKSK` kombinátor egymagában bázis:

    XXX = XKSKX = KKSKSKX = KKSKX = KKX = K

    X(XX) = XXKSK = XKSKKSK = KKSKSKKSK =
        KKSKKSK = KKKSK = KSK = S

Hasonlóan a `Za = aSK` kombinátorral

    Z(Z(ZZ)) = Z(Z(ZSK)) = Z(Z(SSKK)) =
        Z(Z(SK(KK))) = Z(SK(KK))SK =
        SK(KK)SKSK = KS(KKS)KSK =
        SKSK = KK(SK) = K

    Z(Z(Z(ZZ))) = ZK = KSK = S

... de az `S` és `K` szabályokra szükség van


Lambda-kalkulus [Church, 1936]

    <exp> ::= <var> | (λx.<exp>) | (<exp><exp>)
    <var> ::= x | y | ...

- Egyszerűsített zárójelezés
- Jelölés: `λx.(λy.M)` => `λxy.M`

β-redukció:

    (λx.M)a = M[x:=a]

Példa (`M`-en belüli új `x` változók átnevezve!):

    (λx.x(λx.yx))a = (x(λx.yx))[x:=a]
                   = (x(λz.yz))[x:=a]
                   = a(λz.yz)

Ezzel `f(x) = 2*x+1`  =>  `λx.+(*2x)1`


Kapcsolat a kombinátorokkal

    x      => x
    (λx.M) => [Lx.M]
    (MN)   => (MN)

LISP-jellegű jelölés:

    x      => x
    (λx.M) => (lambda (x) M)
    (MN)   => (M N)

- Zárójelek kellenek
- Többargumentumúaknál szóközök

Példa:

    (λxy.xyyz) => (lambda (x y) (((x y) y) z))


Logikai műveletek

    T := (lambda (x y) x)
    F := (lambda (x y) y)

=> Predikátum egyben elágazás

    if := (lambda (p a b) (p a b))

Ennek segítségével:

    not := (lambda (p)   (if p F T))
    and := (lambda (p q) (if p q F))
    or  := (lambda (p q) (if p T q))


Párok

    cons := (lambda (m n) (lambda (z) (z m n)))

Elemek lekérdezése:

    car := (lambda (p) (p T))
    cdr := (lambda (p) (p F))

Ellenőrzés:

    (car (cons x y)) =>
    (car ((lambda (m n)
            (lambda (z) (z m n)))
          x y)) =>
    (car (lambda (z) (z x y))) =>
    ((lambda (p) (p T)) (lambda (z) (z x y))) =>
    ((lambda (z) (z x y)) T) => (T x y) => x


Számok

    0 := (lambda (x) x)
    1 := (cons F 0)
    2 := (cons F 1)
    ...

Növelés/csökkentés:

    +1 := (lambda (n) (cons F n))
    -1 := cdr

Nulla ellenőrzés:

    zerop := car


Változók

    ((lambda (x) (+1 x)) 1) => (+1 x)[x := 1]

helyett

    (let ((x 1))
      (+1 x))

Több argumentumra:

    ((lambda (x y) (cons x (cons y 3))) 1 2) =>
    (cons x (cons y 3))[x := 1, y := 2]

helyett

    (let ((x 1)
          (y 2))
      (cons x (cons y 3)))


Rekurzió

    Y := (lambda (f)
           (let ((g (lambda (x) (f (x x)))))
             (g g)))

Ellenőrzés:

    (Y f) =>

    ((lambda (x) (f (x x)))
     (lambda (x) (f (x x)))) =>

    (f ((lambda (x) (f (x x)))
        (lambda (x) (f (x x))))) =>

    (f (Y f))


Rekurzió II - példa

    plus := (lambda (f)
              (lambda (x y)
                (if (zerop x)
                    y
                    (f (-1 x) (+1 y)))))

    +    := (Y plus)

Ellenőrzés:

    (+ a b) => ((Y plus) a b) =>
    ((plus (Y plus)) a b) =>
    ((lambda (x y)
       (if (zerop x)
           y
           ((Y plus) (-1 x) (+1 y))))
     a b)


Rekurzió III - példa folytatás

    ((lambda (x y)
       (if (zerop x)
           y
           ((Y plus) (-1 x) (+1 y))))
     a b) =>

    (if (zerop a)
        b
        ((Y plus) (-1 a) (+1 b))) =>

    (if (zerop a)
        b
        ((plus (Y plus)) (-1 a) (+1 b))) =>

    ...

=> de csak lusta kiértékeléssel!


Szigorú kiértékelés

    Y := (lambda (f)
           ((lambda (x)
              (f (lambda (y) ((x x) y))))
            (lambda (x)
              (f (lambda (y) ((x x) y))))))

Ellenőrzés:

    (Y f) =>

    (f (lambda (y)
         (((lambda (x) (f (lambda (y) ((x x) y))))
           (lambda (x)
             (f (lambda (y) ((x x) y)))))
          y))) =>

    (f (lambda (y) ((Y f) y)))


Szigorú kiértékelés II

    (+ a b) => ((Y plus) a b) =>

    ((plus (lambda (y1 y2)
             ((Y plus) y1 y2)))
     a b) =>

    ... =>

    (if (zerop a)
        b
        ((plus (lambda (y1 y2)
                 ((Y plus) y1 y2)))
         (-1 a) (+1 b)))

... de sajnos az `if`-hez így is lusta kell


További példák

(`Y` kombinátor helyett rekurzív hivatkozás)

    = := (lambda (x y)
           (or (and (zerop x) (zerop y))
               (and (not (zerop x))
                    (and (not (zerop y))
                         (= (-1 x) (-1 y))))))

Vagy:

    * := (lambda (x y)
           (let ((rec (lambda (n result)
                        (if (zerop n)
                            result
                            (rec (-1 n) 
                                 (+ result y))))))
             (rec x 0)))


További példák II

    (let ((fact (lambda (n)
                  (if (zerop n)
                      1
                      (* n (fact (-1 n)))))))
      (fact 10))

Stb.


Hogyan tovább?

Globális definíciók:

    (define (foo x y) <...>) =>
      (let ((foo (lambda (x y) <...>))) ... )
    (define bar z) =>
      (let ((bar z)) ... )

Párok láncolásából lista (`NIL` záróelem):

    (cons x (cons y (cons z NIL))) ~ [x,y,z]

Típusok (pl. pár első eleme):

    (define (naturalp n) (= (car n) 2))
    (define (nat* x y)
      (cons 2 (* (cdr x) (cdr y))))


Ajánlott irodalom

http://salvi.chaosnet.org/texts/programnyelv.html

1. The Unlambda Programming Language
   http://www.madore.org/~david/programs/unlambda/

2. R. Smullyan (1985): To Mock a Mockingbird
   [A csúfolórigó nyomában - Typotex, 2012]

3. Ch. Hankin (2004):
   An Introduction to Lambda Calculi for Computer Scientists

4. J.R. Hindley, J.P. Seldin (2008):
   Lambda-Calculus and Combinators - An Introduction

5. H. Abelson, G.J. Sussman (1996):
   Structure and Interpretation of Computer Programs

6. S.P. Jones (1987):
   The Implementation of Functional Programming Languages

7. C. Queinnec (2003):
   Lisp in Small Pieces
