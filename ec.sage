def baby_step_giant_step(E, P, Q):
    m = int(E.order()^0.5 + 1)

    baby = []
    b = Q
    for j in range(m):
        baby.append(b)
        b -= P

    giant = m * P
    for i in range(1, m):
        if giant in baby:
            d = i*m + baby.index(giant)
            return d
        else:
            giant += (m * P)
    print("not found")
    return -1

p = 310717010502520989590157367261876774703
a = 2
b = 3

E = EllipticCurve(GF(p), [a, b])
P = E([179210853392303317793440285562762725654, 105268671499942631758568591033409611165])
Q = E([272640099140026426377756188075937988094, 51062462309521034358726608268084433317])

d = 176



# assert Q == d * P

print(d)
print(baby_step_giant_step(E, P, Q))