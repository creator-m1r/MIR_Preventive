# Core Domain Map

## Entities

`Measurement → Observation → Trend → RiskSignal → Recommendation / Referral`

## Cross-cutting

`Provenance + Consent + Audit + Safety Gate`

## Rule

Ни один слой выше Core не должен подменять исходные Observation производными значениями. Производные данные всегда сохраняют ссылку на evidence.
