import vectors
import math

const width : float = 100.0 #diameter of the universe
const dim : int = 3 #number of dimensions


proc dist(A,B, Vector): float =
  #compute modular distance
  for i in 0..dim-1:
    let delta = abs(A[i]-B[i])
    if width - delta < delta:
      result += (width - delta)*(width - delta)
    else:
      result += delta
  result = pow(result,0.5)

proc randomUnitVector():Vector =
  result = initVector(dim,@[0.0,1.0,0.0])
  #random by fair dice

proc getBoundryDistance(center: Vector, direction: Vector, others :seq[Vector])
  #calculates the boundry distance from center to another 
  #used as part of volume approximation