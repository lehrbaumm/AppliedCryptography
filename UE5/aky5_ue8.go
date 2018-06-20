package main

import (
	"fmt"
	"crypto/elliptic"
	crand "crypto/rand"
	"crypto/ecdsa"
	"crypto/sha256"
	"math/big"
)

type message struct {
	msg string
	r, s []byte
}

func main() {
	fmt.Println("Elliptic cuves")
	msg := "Franz jagt im komplett verwahrlosten Taxi quer durch Bayern."
	c := elliptic.P521()
	private, _ := ecdsa.GenerateKey(c, crand.Reader)
	X := private.X
	y := private.Y
	Curve := private.Curve
	pub := ecdsa.PublicKey{
		Curve: Curve,
		X:     X,
		Y:     y,
	}
	channel := make(chan message)
	channel2 := make(chan bool)
	channel3 := make(chan string)
	channel4 := make(chan message)
	go sign(*private, channel3, channel4)
	go verify(pub, channel, channel2)
	channel3 <- msg
	signate := <- channel4
	channel <- signate
	test := <- channel2
	fmt.Println(test)
	channel3 <- "Hallo Welt!"
	signate = <- channel4
	channel <- signate
	test = <- channel2
	fmt.Println(test)
}

func sign(prib ecdsa.PrivateKey, c <- chan string, c2 chan message) {
	for true {
		msg := <- c
		hash := sha256.New().Sum([]byte(msg))
		r, s, _ := ecdsa.Sign(crand.Reader, &prib, hash)
		info := message{
			msg: msg,
			r:   r.Bytes(),
			s:   s.Bytes(),
		}
		c2 <- info
	}
}

func verify(pub ecdsa.PublicKey, c <- chan message, c2 chan bool) {
	for true {
		toverify := <-c
		r := big.Int{}
		r.SetBytes(toverify.r)
		s := big.Int{}
		s.SetBytes(toverify.s)
		message := toverify.msg
		hash := sha256.New().Sum([]byte(message))
		test := ecdsa.Verify(&pub, hash, &r, &s)
		c2 <- test
	}
}
