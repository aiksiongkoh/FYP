Extension { #name : #GFHandle }

{ #category : #'*StCAD-UI-StCAD-UI' }
GFHandle >> popupMenu [
	| cadGO menu |
	cadGO := locator receiver.
	(menu := cadGO menu) notNil ifTrue: [menu startUp evaluateIfNoTarget: cadGO]
]
