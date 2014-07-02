import vectors
import math

const width : float = 100.0 #diameter of the universe
const dim : int = 3 #number of dimensions

proc `+`*(A,B : seq[Vector]) : seq[Vector] =
  result = @[]
  for x in A:
    result.add(x)
  for x in B:
    result.add(x)

proc skip(A: seq[Vector], skip : int ): seq[Vector] =
  result = @[]
  for x in 0..A.len-1:
    if x != skip:
      result.add(A[x])

proc dist(A,B :Vector): float =
  #compute modular distance
  for i in 0..dim-1:
    let delta = abs(A[i]-B[i])
    if width - delta < delta:
      result += (width - delta)*(width - delta)
    else:
      result += delta
  result = pow(result,0.5)

proc randomUnitVector():Vector =
  var thetas : seq[float] = @[0.5*PI]
  for i in 0..dim-2:
    let rnum : float = random(1.0*2.0*PI)
    thetas.add(rnum)
  result = initZeroVector(dim)
  for i in 0..dim-1:
    result[i] = 1.0
    for j in 0..i:
      if j == dim-1:
        break
      if j < i:
        result[i]= result[i]* sin(thetas[j])
      if j == i:
        result[i]= result[i]* cos(thetas[j])
    
proc getBoundryDistance(center: Vector, direction: Vector, others :seq[Vector]): float =
  #calculates the boundry distance from center to another 
  #used as part of volume approximation
  var dists : seq[float] = @[]
  for o in others:
    let delta = o - center
    let theta = angle(delta,direction)
    let half_dist = 0.5 * norm(delta)
    dists.add(half_dist/cos(theta))
  return max(dists)

proc approxVoronoiVolume(center: Vector, others: seq[Vector] ):float =
  for i in 0..1000:
    result += getBoundryDistance(center,randomUnitVector(),others)
  result = result / 1001.0
  result = result

var nodes : seq[Vector] = @[]
for i in 0..20:
  nodes.add( randomUnitVector()*random(50.0) )
for i in 0..20:
  var center : Vector = nodes[i]
  var others : seq[Vector] = skip(nodes,i)
  echo(approxVoronoiVolume(center,others))
