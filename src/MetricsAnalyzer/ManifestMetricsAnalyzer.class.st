"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMetricsAnalyzer,
	#superclass : #PackageManifest,
	#category : #'MetricsAnalyzer-Manifest'
}

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MetricsAnalyzer)) #'2024-03-27T16:09:33.215-04:00') )
]

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MetricsAnalyzer)) #'2024-03-27T16:10:16.395-04:00') )
]

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleNoClassCommentRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MetricsAnalyzer)) #'2024-03-28T23:37:17.761-04:00') )
]

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleReClassNotCategorizedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#MetricsAnalyzerClass)) #'2024-03-28T23:37:34.892-04:00') )
]

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MetricsAnalyzer)) #'2024-03-27T16:09:45.791-04:00') )
]

{ #category : #'code-critics' }
ManifestMetricsAnalyzer class >> ruleStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MetricsAnalyzer)) #'2024-03-27T16:10:01.75-04:00') )
]
