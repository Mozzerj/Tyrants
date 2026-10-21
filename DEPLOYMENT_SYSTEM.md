# Tyrants v4 deployment and intelligence start

A new campaign begins in `deployment`, not `running`.

- The server generates 2- or 3-way angular deployment regions around the Altis centre.
- Candidate rotations are scored against coarse usable-land samples and strategic locations so one faction is not deliberately given an obviously empty sector.
- All players may see the broad WEST/EAST/INDEPENDENT regions. This is intentional starting intelligence.
- Exact hostile HQ positions are never included in normal faction replication.
- Human-controlled factions click and confirm an HQ inside their own region.
- AI-controlled factions evaluate positions inside the same region and use the same server validation rules.
- A 2.5 km boundary buffer keeps HQs away from the sector dividing lines.
- Players are damage-protected in staging and war systems are paused during deployment.
- Only when every active faction is ready does the server create HQs, claim small initial enclaves, enable hostility and start economy/capture/AI scheduling.
- The generated sectors and confirmed bases are persistent. The save format revision is now 2; earlier v4 revision-1 checkpoints are intentionally rejected.

The deployment regions remain faintly visible on the normal strategic map after the war begins, providing rough historical knowledge of where each faction started without revealing HQ coordinates.
