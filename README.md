# Exit Generation Rules
Types of symmetries
1. Parallel Symmetry: Two exits lie along the same line on opposite walls. The line is parallel to either adjacent wall.
2. Centre Intersector Symmetry: Two exits lie along the same line on opposite walls. The line intersects the centre of the room.
3. Equidistance Symmetry: Three or more exits on the same wall are equally spaced
4. Equiopposing Symmetry: Two exits on the same wall are spaced equally from opposite walls
5. Diagonal Symmetry: Two exits on adjacent walls lie along a diagonal that cuts the adjacent walls at equal distances from their intersection

All exits for a particular room must follow atleast one of these symmetries, except if the room has only one exit.

Steps for door generation
1. First choose the number of doors we want (say, 6)
2. Choose any symmetries that can be applied randomly, ensuring that each door has atleast one symmetry.
3. Generate doors applying these symmetries.
