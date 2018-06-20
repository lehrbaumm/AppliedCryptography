package main

import (
	crand "crypto/rand"
	"crypto/sha1"
	"fmt"
	"log"
	"math/big"
	mrand "math/rand"
	"time"
)

func main() {
	start := time.Now()
	p, q := GeneratePQ(256, 3072)
	fmt.Printf("p = %d\nq = %d\n", p, q)
	g := GenerateG(p, q)
	fmt.Printf("g = %d\n", g)
	t := time.Now()
	elapsed := t.Sub(start)
	fmt.Printf("Elapsed = %f\n", elapsed.Seconds())
	k := big.NewInt(1)
	minus := big.NewInt(1)
	fmt.Printf("q %% (p - 1) = %d\n", k.Rem(k.Sub(p, minus), q))
	fmt.Printf("g^q %% p = %d\n", k.Exp(g, q, p))
}

func randomBigInt(nb int) *big.Int {
	b := make([]byte, nb)
	_, err := crand.Read(b)
	if err != nil {
		return nil
	}
	r := new(big.Int)
	r.SetBytes(b)
	return r
}

func GeneratePQ(m, L int) (p, q *big.Int) {
	mp := m/160 + 1
	Lp := L/160 + 1
	Np := L/1024 + 1

	var SEED *big.Int
	for {
		SEED = randomBigInt(m / 8)
		if SEED == nil {
			continue
		}
		U := big.NewInt(0)
		for i := 0; i < mp; i++ {
			Up := new(big.Int)
			xorPart1 := new(big.Int)
			t := new(big.Int)
			t.Add(SEED, big.NewInt(int64(i)))
			sha := sha1.Sum(t.Bytes())
			xorPart1.SetBytes(sha[:])
			xorPart2 := new(big.Int)
			t.Add(t, big.NewInt(int64(mp)))
			sha = sha1.Sum(t.Bytes())
			xorPart2.SetBytes(sha[:])
			Up.Xor(xorPart1, xorPart2)
			v := new(big.Int)
			v.Mul(big.NewInt(160), big.NewInt(int64(i)))
			v.Exp(big.NewInt(2), v, nil)
			Up.Mul(Up, v)
			U.Add(U, Up)
		}
		t := big.NewInt(2)
		t.Exp(t, big.NewInt(160), nil)
		U.Mod(U, t)

		q = new(big.Int)
		q.Set(U)
		q.SetBit(q, 0, 1)
		q.SetBit(q, m-1, 1)
		if q.ProbablyPrime(100) {
			break
		}
	}
	counter := 0
	for {
		R := new(big.Int)
		R.Set(SEED)
		t := new(big.Int)
		t.Mul(big.NewInt(2), big.NewInt(int64(mp)))
		R.Add(R, t)
		t.Mul(big.NewInt(int64(Lp)), big.NewInt(int64(counter)))
		R.Add(R, t)
		V := big.NewInt(0)
		for i := 0; i < Lp; i++ {
			sha := new(big.Int)
			sha.Add(R, big.NewInt(int64(i)))
			shaBytes := sha1.Sum(sha.Bytes())
			sha.SetBytes(shaBytes[:])
			second := new(big.Int)
			second.Mul(big.NewInt(160), big.NewInt(int64(i)))
			second.Exp(big.NewInt(2), second, nil)
			sha.Mul(sha, second)
			V.Add(V, sha)
		}
		W := new(big.Int)
		t.Exp(big.NewInt(2), big.NewInt(int64(L)), nil)
		W.Mod(V, t)
		X := new(big.Int)
		X.SetBit(W, L-1, 1)
		p = new(big.Int)
		p.Set(X)
		t.Mul(big.NewInt(2), q)
		X.Mod(X, t)
		p.Sub(p, X)
		p.Add(p, big.NewInt(1))
		t.Exp(big.NewInt(2), big.NewInt(int64(L-1)), nil)
		if p.Cmp(t) == 1 {
			if p.ProbablyPrime(100) {
				break
			}
		}
		counter++
		if counter >= 4096*Np {
			log.Fatalf("Error finding q \n")
			return nil, nil
		}
	}
	return
}

func GenerateG(p, q *big.Int) (g *big.Int) {
	randBase := mrand.New(mrand.NewSource(time.Now().UnixNano()))
	g = new(big.Int)
	j := new(big.Int)
	j.Sub(p, big.NewInt(1))
	j.Div(j, q)
	for {
		h := new(big.Int)
		h.Rand(randBase, p)
		if h.Cmp(big.NewInt(0)) == 0 {
			continue
		}
		g.Exp(h, j, p)
		if g.Cmp(big.NewInt(1)) != 0 {
			break
		}
	}
	return
}
