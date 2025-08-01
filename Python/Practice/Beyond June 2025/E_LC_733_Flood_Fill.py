# 733. Flood Fill
'''
You are given an image represented by an m x n grid of integers image, where image[i][j] represents the pixel value of the image. You are also given three integers sr, sc, and color. Your task is to perform a flood fill on the image starting from the pixel image[sr][sc].

To perform a flood fill:

Begin with the starting pixel and change its color to color.
Perform the same process for each pixel that is directly adjacent (pixels that share a side with the original pixel, either horizontally or vertically) and shares the same color as the starting pixel.
Keep repeating this process by checking neighboring pixels of the updated pixels and modifying their color if it matches the original color of the starting pixel.
The process stops when there are no more adjacent pixels of the original color to update.
Return the modified image after performing the flood fill.

 

Example 1:

Input: image = [[1,1,1],[1,1,0],[1,0,1]], sr = 1, sc = 1, color = 2

Output: [[2,2,2],[2,2,0],[2,0,1]]

From the center of the image with position (sr, sc) = (1, 1) (i.e., the red pixel), all pixels connected by a path of the same color as the starting pixel (i.e., the blue pixels) are colored with the new color.

Note the bottom corner is not colored 2, because it is not horizontally or vertically connected to the starting pixel.

Example 2:

Input: image = [[0,0,0],[0,0,0]], sr = 0, sc = 0, color = 0

Output: [[0,0,0],[0,0,0]]

Explanation:

The starting pixel is already colored with 0, which is the same as the target color. Therefore, no changes are made to the image.

 

Constraints:

m == image.length
n == image[i].length
1 <= m, n <= 50
0 <= image[i][j], color < 216
0 <= sr < m
0 <= sc < n
'''
class Solution:
    def floodFill(self, image: List[List[int]], sr: int, sc: int, color: int) -> List[List[int]]:
        scope = [[sr, sc]]
        m = len(image)
        n = len(image[0])
        init_c = image[sr][sc]
        # print('init color = ', init_c)

        while scope:
            curr_sr, curr_sc = scope.pop()
            # print('Curr Index = ', curr_sr, curr_sc)

            c = image[curr_sr][curr_sc]
            # print('curr color = ', c)

            if init_c == c:
                if c == color:
                    return image
                else:    
                    image[curr_sr][curr_sc] = color
                    # print(curr_sr, curr_sc)
                    left = curr_sc - 1
                    right = curr_sc + 1
                    up = curr_sr - 1
                    down = curr_sr + 1

                    if left >= 0:
                        if init_c == image[curr_sr][left]:
                            scope.append([curr_sr, left])
                            # print('left ', scope)
                    if right < n:
                        if init_c == image[curr_sr][right]:
                            scope.append([curr_sr, right])
                            # print('right ', scope)

                    if up >= 0:
                        if init_c == image[up][curr_sc]:
                            scope.append([up, curr_sc])
                            # print('up ', scope)
                    if down < m:
                        if init_c == image[down][curr_sc]:
                            scope.append([down, curr_sc])
                            # print('down ', scope)
            
        return image
