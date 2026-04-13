# ``OneStepSDK/Insights``

AI-powered gait insights, trend analysis, fall risk assessment, and clinical report generation.

## Overview

Access `Insights` via `OneStep.shared.insights`. This protocol provides:
- Per-measurement AI insights (parameter interpretation, comparisons, education)
- Longitudinal trend analysis for any gait parameter
- Fall risk assessment across a set of measurements
- Clinical-grade PDF-ready reports with normative comparisons

### Fetching Insights

```swift
let insights = OneStep.shared.insights

// Single measurement
let measurementInsights = try await insights.getInsights(for: measurementId)
for insight in measurementInsights {
    print("[\(insight.insightType)] \(insight.textMarkdown)")
}

// Multiple measurements
let insightMap = try await insights.getInsights(for: [id1, id2, id3])
```

### Trend Analysis

```swift
let trend = try await insights.analyzeTrend(
    for: .walkingVelocity,
    from: Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
    to: Date()
)

switch trend.trend {
case .improving:
    print("Velocity improved by \(trend.percentageChange ?? 0)% over \(trend.measurementCount) sessions")
case .declining:
    print("Velocity declined — consider clinical review")
case .stable:
    print("Velocity is stable")
case .insufficient_data:
    print("Not enough data yet")
}
```

### Fall Risk Assessment

```swift
let measurements = try OneStep.shared.motionLab.getMeasurements(
    request: TimeRangedDataRequest(startTime: nil, endTime: nil)
)
let risk = try await insights.assessFallRisk(measurements: measurements)

print("Risk level: \(risk.riskLevel.rawValue)")   // low / moderate / high / critical
print("Score: \(risk.riskScore)")
print("Factors: \(risk.contributingFactors.joined(separator: ", "))")
print("Recommendations: \(risk.recommendations.joined(separator: "\n"))")
```

### Clinical Report

```swift
let report = try await insights.generateClinicalReport(
    measurementIds: selectedIds,
    includeComparisons: true
)

print(report.summary)
for (param, comparison) in report.normativeComparisons ?? [:] {
    print("\(param.rawValue): percentile \(Int(comparison.percentile))th — \(comparison.interpretation)")
}
```

### Parameter Metadata & Norms

```swift
let service = await insights.getMotionDataService()

if let meta = service.getParameterMetadata(by: .walkingCadence) {
    print("Display name: \(meta.displayName), units: \(meta.units ?? "—")")
}

if let norm = service.getNorm(by: .walkingVelocity) {
    print("Normal range: \(norm.lowLimit)–\(norm.highLimit)")
}
```

## Topics

### Insights

- ``Insights/getInsights(for:)-7b8fk``
- ``Insights/getInsights(for:)-3m4n``

### Trend & Risk

- ``Insights/analyzeTrend(for:from:to:)``
- ``Insights/assessFallRisk(measurements:)``

### Clinical Reporting

- ``Insights/generateClinicalReport(measurementIds:includeComparisons:)``

### Parameter Data

- ``Insights/getMotionDataService()``
