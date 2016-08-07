# Möbius Swan

We essentially solved the problem without solving the problem.  Our approach is:

1. Calculate a bounding box surrounding the problems silhouette
2. Fold a piece of paper horizontally and vertically to exactly fit that box
3. Remove folds if the solution would be over the size limit
4. Translate the folded shape into the bounding box

So we're just covering the shape with a rectangle and trying to minimize the overhang.
