## Database Recommendation

This section evaluates whether MySQL or MongoDB is the better choice for a healthcare startup building a patient management system, with consideration for an additional fraud detection module.

### Core Recommendation: MySQL for Patient Management

For the core patient management system, **MySQL is the stronger choice**. The primary reason is ACID compliance. In healthcare, data integrity is non-negotiable — a patient's medication record, allergy history, or diagnostic report must be written completely or not at all. MySQL's ACID guarantees (Atomicity, Consistency, Isolation, Durability) ensure that if a transaction fails midway — for example, updating a patient's prescription while simultaneously logging a billing entry — the entire operation rolls back cleanly. No partial data is committed. MongoDB, which follows the BASE model (Basically Available, Soft state, Eventually consistent), prioritises availability over strict consistency. In a retail or social media context, eventual consistency is acceptable. In a clinical setting, a doctor reading a stale or incomplete record could cause patient harm.

The CAP theorem further supports this choice. MySQL, as a CP (Consistency + Partition Tolerance) system, guarantees that every read returns the most recent write, even if it means temporarily refusing a request. MongoDB, configured as AP (Availability + Partition Tolerance) by default, might return slightly outdated data during a network partition — a risk that is unacceptable for clinical records.

Patient data also has a well-defined, stable schema: patient demographics, appointments, prescriptions, lab results, billing. This relational structure with foreign key constraints is precisely what MySQL was built for. Enforced relationships ensure referential integrity — you cannot have a prescription record without a valid patient record.

### Fraud Detection Module: Switch to MongoDB

The answer changes significantly when adding a fraud detection module. Fraud detection requires analysing large volumes of unstructured, high-velocity event data — login attempts, access logs, unusual billing patterns, device fingerprints — where the schema varies per event type and evolves rapidly. MongoDB's flexible document model handles this well; each fraud event can carry different fields without requiring schema migrations. Its horizontal scaling (sharding) also supports the high write throughput that fraud logging demands.

### Final Recommendation

Use **both in combination**: MySQL as the system of record for patient data (guaranteeing ACID integrity), and MongoDB as the event store for the fraud detection layer (handling flexible, high-volume logs). This hybrid architecture leverages the strengths of each database where they matter most.