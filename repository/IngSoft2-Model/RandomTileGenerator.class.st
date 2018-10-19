Class {
	#name : #RandomTileGenerator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomTileGenerator >> generateTile [
| aRandomSeries aRandomInt  |
	
	aRandomSeries := Random new.
	aRandomInt := aRandomSeries nextInt: 100.
	
	aRandomInt < 49
		ifTrue: [ ^ NormalTile new ].
	aRandomInt > 48 & (aRandomInt < 69)
		ifTrue: [ ^ WormHole new ].
	aRandomInt > 68 & (aRandomInt < 89)
		ifTrue: [ ^ SpeedUp new ].
	aRandomInt > 88 & (aRandomInt < 99)
		ifTrue: [ ^ MoonWalk new ].
	aRandomInt > 98 & (aRandomInt < 101)
		ifTrue: [ ^ AtomicBomb new ]
]
