Class {
	#name : #RandomDeck,
	#superclass : #Deck,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomDeck >> drawCard [
	^ OrderedCollection new
  add: Overload new;
  add: Speed new;
  add: Acceleration new;
  add: Cancellation new;
  add: Redo new;
  add: Repeat new;
  atRandom
]
