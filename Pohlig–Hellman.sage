from random import randint

def pollards_rho(E, P, Q, div):

    n = E.order()
    R = []
    Rab = []
    a = randint(0, n)
    b = randint(0, n)
    R.append((a*P) + (b*Q))
    Rab.append([a, b])

    M = []
    Mab = []
    for i in range(div):
        a = randint(0, n)
        b = randint(0, n)
        M.append((a*P) + (b*Q))
        Mab.append([a, b])

    S = R[0]
    i = 0
    while True:
        m = int(S[0]) % div
        S = S + M[m]
        Sa = Rab[i][0] + Mab[m][0]
        Sb = Rab[i][1] + Mab[m][1]

        if S in R:
            Ra, Rb = Rab[R.index(S)]
            d = (Sa - Ra)*inverse_mod((Rb - Sb), n) % n
            return d
        else:
            R.append(S)
            Rab.append([Sa, Sb])
            i += 1

p = 310717010502520989590157367261876774703
a = 2
b = 3
g_x = 179210853392303317793440285562762725654
g_y = 105268671499942631758568591033409611165

F = FiniteField(p)
E = EllipticCurve(F, [a, b])

# P = nG
P = E.point((280810182131414898730378982766101210916,
            291506490768054478159835604632710368904))
G = E.point((g_x, g_y))

# assert Q == d * P
# print(d)

print(pollards_rho(E, P, Q, 20))

