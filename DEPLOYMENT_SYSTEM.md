# Tyrants v4 deployment and intelligence start

A new campaign begins in `deployment`, not `running`.

- The server generates 2- or 3-way angular deployment regions around the Altis centre.
- Candidate rotations are scored using **usable land outside the no-HQ buffer**, not just total land in each wedge. This prevents one faction receiving a nominally large region with almost nowhere legal to place an HQ.
- All players may see the broad WEST/EAST/INDEPENDENT regions. This is intentional starting intelligence.
- The deployment dialog and the normal in-game strategic map now use the same Draw-event sector geometry; the old coarse local-marker colour grid is no longer used.
- Exact hostile HQ positions are never included in normal faction replication.
- Human-controlled factions click and confirm an HQ inside their own region.
- AI-controlled factions evaluate positions inside the same region and use the same server validation rules.
- A 2.5 km no-HQ distance is enforced on **both sides of every shared faction boundary**. The deployment map shows these shared corridors in grey.
- Players are damage-protected in staging and war systems are paused during deployment.
- Only when every active faction is ready does the server create HQs, claim small initial enclaves, enable hostility and start economy/capture/AI scheduling.
- The generated sectors and confirmed bases are persistent. Deployment layout version 2 forces old unconfirmed wedge layouts to regenerate with the balanced usable-land scoring.

The deployment regions remain faintly visible on the normal strategic map after the war begins, providing rough historical knowledge of where each faction started without revealing HQ coordinates.
