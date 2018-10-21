Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testDeterministicBoardIsCreatedWithGenerator [
	| board wormHole normalTile |
	wormHole := WormHole new.
	normalTile := NormalTile new.
	board := Board withGenerator: (DeterministicTileGenerator withBoard: (Array with: wormHole with: normalTile)) withTiles: 20.
	self assert: ((board tiles at: 1) isKindOf: WormHole)
]

{ #category : #tests }
BoardTest >> testDeterministicBoardIsCreatedWithTiles [
	| board wormHole normalTile |
	wormHole := WormHole new.
	normalTile := NormalTile new.
	board := Board madeOf: (Array with: wormHole with: normalTile with: wormHole with: normalTile).
	self assert: ((board tiles at: 1) isKindOf: WormHole)
]

{ #category : #tests }
BoardTest >> testRandomBoardIsCreated [
	| board |
	board := Board withGenerator: RandomTileGenerator  new withTiles: 20.
	self
		assert:
			((board tiles at: 2) isKindOf: NormalTile) | ((board tiles at: 2) isKindOf: AtomicBomb) | ((board tiles at: 2) isKindOf: WormHole)
				| ((board tiles at: 2) isKindOf: SpeedUp) | ((board tiles at: 2) isKindOf: MoonWalk)
]
