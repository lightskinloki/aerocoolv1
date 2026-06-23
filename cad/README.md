# CAD Files

## Status

**These files are placeholders.** The actual STL files will be uploaded once the prototype is finalized and tested.

## File Structure

```
cad/
├── funnel-array-v1.stl          # 7-funnel hexagonal array (one stage)
├── base-frame-v1.stl            # Structural base with mounting points
├── top-cap-v1.stl              # Exhaust cap with chimney vents
├── side-panel-v1.stl           # Exterior panel (4x required)
├── water-system-v1.stl         # Distribution channels + reservoir
├── bracket-v1.stl              # 3D-printable bracket (for DIY builders)
└── complete-tower-v1.stl       # Full assembly (for reference only)
```

## Version History

| Version | Date | Changes | Status |
|---------|------|---------|--------|
| v0.1 | [date] | Initial funnel design | In testing |
| v0.2 | [date] | 7-funnel array + base frame | In testing |
| v0.3 | [date] | 3-stage stack + water system | In testing |
| v1.0 | [date] | Final 6-stage tower | Pending validation |

## Contributing

If you improve the design:
1. Fork the repository
2. Modify CAD files in your CAD software (Fusion 360, Blender, etc.)
3. Export as STL with clear naming: `funnel-array-v1.1-[yourname].stl`
4. Submit a pull request with description of changes and test results

## Design Constraints

- All parts must be printable on 220×220×250mm build volume
- No supports required (15° self-supporting taper minimum)
- Snap-fit joints: 0.2mm tolerance, audible click confirmation
- Water system: 100% infill, leak-proof channels
- Funnel throat: 2.5mm ± 0.1mm critical dimension

---

*Back to [README](../README.md)*
