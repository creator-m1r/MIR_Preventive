# Core safety test plan

## Quality

- invalid observation must not pass the Safety Gate;
- missing observation must not become zero;
- low-quality observation must request recheck;
- repeat-required observation must request recheck.

## Provenance

- every derived object must retain input references;
- algorithm/model version must be preserved;
- audit records must contain actor and timestamp.

## AI boundary

- AI cannot create missing measurements;
- AI cannot override deterministic safety decisions;
- uncertainty must survive presentation-layer transformation.

## Clinical boundary

- Core entities do not encode a diagnosis;
- no medication or dosage logic belongs in Core;
- unvalidated thresholds are prohibited.
