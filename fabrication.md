# fabrication

## enclosures

### assembling faceplates with magnetic attachments

This is three layers.  Bottom and middle plates have holes for magnets. Top plate
does not, but needs to have magnets glued to it in the exact positions so that the 
magnets and plates align.

1. glue the bottom plate to the middle plate.
1. turn the assembly so the middle plate is face-down on a flat surface.
1. place the top plate on the bottom of that stack, face down, and align the plates.
1. put a dab of super glue through each magnet hole onto the underside of the top plate (which is facing upward).
1. put one 5mm magnet in each of the holes through the bottom plate (which is now facing upward).  Push the magnets down through the middle plate so that they make firm and flat contact with the top plate and the glue.
1. carefully lift the bottm+middle assembly up to reveal the magnets that are now on the underside of the top plate. This is so that the glue does not spread and stick the top plate to the middle plate.
1. let the glue set.  The reason for gluing the magnets to the top plate first is so that they can be separated from the magnets that will go into the middle plate. Without being glued to the top plate, they would stick to the magnets in the middle plate and get stuck there. 
1. mate each magnets with another.  
1. insert the mated magnet stacks into the bottom+middle assembly.  Align the plates.  This will result in the second set of magnets positioned into their respective holes in the bottom plate.
1. secure the bottom plate magnets with epoxy through the underside of the bottom plate.  

## PCBs

### KiCad checklist

Follow this checklist before producing plots for PCB fabrication

- [ ] Tools --> Cleanup tracks and vias
- [ ] Tools --> Cleanup graphics and check all the boxes
- [ ] Run the resource checker and make sure there are no unconnected elements
- [ ] Delete all fab output files
- [ ] Render PCB in with 3D viewer and visually check.

### Placing a PCB order with JLCPCB

- File --> Fabrication Output --> Gerbers --> Plot
- File --> Fabrication Output --> Gerbers --> Generate Drill Files
- zip the outputs and upload to JLCPCB
- Check the preview renderings to verify  
