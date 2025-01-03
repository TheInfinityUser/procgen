## Exit Generation
Exits are generated randomly based on groupings.
If there are multiple exits with insufficient spacing between opposite walls, increase the separator size of the room and continue separation. Separator size increases based on the range (no. of similar exits) / 2 to (no. of similar exits). For each separator size, check whether construction of paths is possible, if so construct the paths, otherwise increase separator size and try again.
