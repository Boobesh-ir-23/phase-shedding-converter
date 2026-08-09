"""
Generate IEEE-style schematic: Topology 2
Two-phase interleaved buck + shared boost.

Run: python gen_topology2_schematic.py

Outputs (same folder):
  fig_topology2_schematic.png  (300 dpi)
  fig_topology2_schematic.pdf  (vector — preferred in Overleaf)
  fig_topology2_schematic.svg
"""
from pathlib import Path

import schemdraw
import schemdraw.elements as elm

OUT_DIR = Path(__file__).resolve().parent


def draw_topology2() -> schemdraw.Drawing:
    """Topology 2 power stage — paper figure (put title in LaTeX caption)."""
    d = schemdraw.Drawing(unit=2.15, fontsize=12, lw=1.6)
    d.config(bgcolor="white")

    # ===== Input =====
    d += elm.SourceV().up().label(r"$V_{\mathrm{in}}$", loc="left")
    d += elm.Line().right().length(0.85)
    d += elm.Dot()
    d.push()
    d += elm.Capacitor().down().label(r"$C_{\mathrm{in}}$", loc="right")
    d += elm.Ground()
    d.pop()
    d += elm.Line().right().length(1.1)
    d += (split := elm.Dot())

    # ===== Phase 1 (upper, always active) =====
    d.push()
    d += elm.Line().up().length(2.0)
    d += elm.Line().right().length(0.55)
    d += elm.Switch().right().label(r"$S_1$", loc="top")
    d += elm.Line().right().length(0.4)
    d += (n1 := elm.Dot())

    # Freewheel D1: offset left so its vertical does not share x with D2
    d.push()
    d += elm.Line().left().length(0.9)
    d += elm.Dot()
    d += elm.Diode().down().reverse().length(1.35).label(r"$D_1$", loc="left")
    d += elm.Line().down().length(1.05)
    d += elm.Ground()
    d.pop()

    d += elm.Line().right().length(0.25)
    d += elm.Inductor2().right().label(r"$L_1$", loc="top")
    d += elm.Line().right().length(0.4)
    d += elm.Dot()
    d += elm.Line().down().length(2.0)
    d += (mid := elm.Dot())
    d.pop()

    # ===== Phase 2 (sheddable) =====
    d += elm.Line().right().at(split.center).length(0.55)
    d += elm.Switch().right().label(r"$S_2$", loc="top")
    d += elm.Line().right().length(0.4)
    d += (n2 := elm.Dot())

    d.push()
    d += elm.Diode().down().reverse().length(1.35).label(r"$D_2$", loc="right")
    d += elm.Line().down().length(0.2)
    d += elm.Ground()
    d.pop()

    d += elm.Line().right().length(0.25)
    d += elm.Inductor2().right().label(r"$L_2$", loc="bot")
    d += elm.Line().tox(mid.center)
    d += elm.Dot()

    # ===== Shared boost + output =====
    d += elm.Line().right().at(mid.center).length(1.35)
    d += (nb := elm.Dot())
    d.push()
    d += elm.Switch().down().label(r"$S_{\mathrm{B}}$", loc="right")
    d += elm.Ground()
    d.pop()

    d += elm.Diode().right().at(nb.center).label(r"$D_{\mathrm{B}}$", loc="top")
    d += elm.Dot()
    d.push()
    d += elm.Capacitor().down().label(r"$C_{\mathrm{o}}$", loc="left")
    d += elm.Ground()
    d.pop()

    d += elm.Line().right().length(1.1)
    d += elm.Dot()
    d.push()
    d += elm.ResistorIEC().down().label(r"$R_{\mathrm{L}}$", loc="right")
    d += elm.Ground()
    d.pop()

    d += elm.Line().right().length(0.75)
    d += elm.Dot(open=True).label(r"$V_{\mathrm{out}}$", loc="right")

    # Footnote (optional; delete in Overleaf if caption is enough)
    d += (
        elm.Label()
        .at((0, -2.35))
        .label(
            r"Phase shedding: gate-off $S_2$ at light load ($S_1$ remains active). "
            r"Example rails: $48\,\mathrm{V}\!\rightarrow\!12/24\,\mathrm{V}$.",
            fontsize=9,
            halign="left",
        )
    )

    return d


def main() -> None:
    d = draw_topology2()
    for name, kwargs in (
        ("fig_topology2_schematic.png", {"dpi": 300}),
        ("fig_topology2_schematic.pdf", {}),
        ("fig_topology2_schematic.svg", {}),
    ):
        path = OUT_DIR / name
        d.save(str(path), **kwargs)
        print(f"Saved {path}")


if __name__ == "__main__":
    main()
