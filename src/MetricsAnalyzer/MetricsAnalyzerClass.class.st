Class {
	#name : #MetricsAnalyzerClass,
	#superclass : #Object,
	#category : #MetricsAnalyzer
}

{ #category : #'accessing - classes' }
MetricsAnalyzerClass >> analyzeClass: aClass [
	    | className numberOfLinesOfClass startOfLine endOfLine startOfPos endOfPos methods csvData |
    className := aClass name.
    numberOfLinesOfClass := aClass numberOfLinesOfCode.
    startOfLine := aClass sourceAnchor startLine.
    endOfLine := aClass sourceAnchor endLine.
    startOfPos := aClass sourceAnchor startPos.
    endOfPos :=  aClass sourceAnchor endPos.
    
    (numberOfLinesOfClass >= 0) ifTrue: [
	"Debut de la partie pour l'affichage sur console"
        "Transcript
            show: 'Classe : ', className, ' - Nombre de lignes de code : ', numberOfLinesOfClass printString, ' - StartL/EndL : ', startOfLine printString ,'/', endOfLine printString; cr."
	"Fin de la partie pour l'affichage sur console"
	
        csvData := OrderedCollection new.
        csvData add: #(Name ClassOrMethod LOC CC StartLine EndLine StartPos EndPos FileName).
        csvData add: (OrderedCollection with: className) , #C, (OrderedCollection with: numberOfLinesOfClass) , #- , (OrderedCollection with: startOfLine) , (OrderedCollection with: endOfLine) , (OrderedCollection with: startOfPos) , (OrderedCollection with: endOfPos) , (OrderedCollection with: aClass sourceAnchor fileName printString).

        methods := aClass methods.
        
        methods ifNotNil: [
            methods do: [ :method |
                | methodName numberOfLines cyclomaticComplexity |
                methodName := method name.
                numberOfLines := method numberOfLinesOfCode.
                cyclomaticComplexity := method cyclomaticComplexity.
                startOfLine := method sourceAnchor startLine.
                endOfLine := method sourceAnchor endLine.
                startOfPos := method sourceAnchor startPos.
                endOfPos :=  method sourceAnchor endPos.
                
                (numberOfLines >= 0 and: [cyclomaticComplexity >= 0]) ifTrue: [
	"Debut de la partie pour l'affichage sur console"
                    "Transcript
                        show: '    Méthode : ', methodName, ' - Nombre de lignes de code : ', numberOfLines printString,
                        ' - Complexité cyclomatique : ', cyclomaticComplexity printString; cr."
	"Fin de la partie pour l'affichage sur console"

                    csvData add: (OrderedCollection with: methodName) , #M, (OrderedCollection with: numberOfLines) , (OrderedCollection with: cyclomaticComplexity) , (OrderedCollection with: startOfLine) , (OrderedCollection with: endOfLine) , (OrderedCollection with: startOfPos) , (OrderedCollection with: endOfPos).
                ].
            ].
        ].

			self writeCsvData: csvData forClass: className.
    	].
]

{ #category : #abstract }
MetricsAnalyzerClass >> analyzeClassLOCandCC: aClass [
    | className numberOfLinesOfClass methods csvData |
    className := aClass name.
    numberOfLinesOfClass := aClass numberOfLinesOfCode.

    (numberOfLinesOfClass >= 0) ifTrue: [
        csvData := OrderedCollection new.
        csvData add: #(Name ClassOrMethod LOC CC).

        methods := aClass methods.
        methods ifNotNil: [
            methods do: [ :method |
                | methodName numberOfLines cyclomaticComplexity nameCollection locCollection ccCollection |
                methodName := method name.
                numberOfLines := method numberOfLinesOfCode.
                cyclomaticComplexity := method cyclomaticComplexity.

                (numberOfLines >= 0 and: [cyclomaticComplexity >= 0]) ifTrue: [
                    nameCollection := OrderedCollection new.
                    nameCollection add: methodName.
                    locCollection := OrderedCollection new.
                    locCollection add: numberOfLines.
                    ccCollection := OrderedCollection new.
                    ccCollection add: cyclomaticComplexity.
                    csvData add: nameCollection, #M, locCollection, ccCollection.
                ].
            ].
        ].
        self writeCsvData: csvData forClass: className.
    ].

]

{ #category : #'accessing - arguments' }
MetricsAnalyzerClass >> analyzeModelClasses: anIndex [
    | tsModel allModelClasses |
    tsModel := self mooseModelAt: anIndex.
    allModelClasses := tsModel allModelClasses.

    allModelClasses do: [ :class |
        self analyzeClass: class.
    ].

]

{ #category : #'accessing - arguments' }
MetricsAnalyzerClass >> analyzeModelClassesLOCandCC: anIndex [
    | tsModel allModelClasses |
    tsModel := self mooseModelAt: anIndex.
    allModelClasses := tsModel allModelClasses.

    allModelClasses do: [ :class |
        self analyzeClassLOCandCC: class.
    ].

]

{ #category : #accessing }
MetricsAnalyzerClass >> mooseModelAt: anIndex [
    ^MooseModel root at: anIndex

]

{ #category : #writing }
MetricsAnalyzerClass >> writeCsvData: csvData forClass: className [
    | csvFileName csvFilePath |
    csvFileName := className, '_metrics.csv'.
    csvFilePath := 'metrics/', csvFileName.

    csvFilePath asFileReference writeStreamDo: [ :writeStream |
        (NeoCSVWriter on: writeStream)
            fieldWriter: #quoted;
            nextPutAll: csvData.
    ].

]
