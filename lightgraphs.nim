#lightGraph is a simple graph implementation
# graphs are typed Lgraph[nodeType, edgeType]
# edgeType is assumed to be well defined for +
# please, no negative weight cycles

type
  Lgraph[N,E] = object
    nodes : seq[N] #set of nodes in the graph
    edges : seq[E] #set of edges in the graph
    capacity : int #maximum number of manageable nodes

proc initLgraph*(capacity:int): Lgraph[N,E] =
  new(result)
  result.nodes = @[]
  result.edges = @[]
  result.capacity = capacity
  for i in 1..capacity*capacity:
    result.edges.add(nil)

proc addNode*[N,E](g: Lgraph[N,E], node : N) : int =
  #adds a node to the graph
  #returns the integer ID of that node in the graph
  if g.nodes.len >= g.capacity:
    return -1 #only add nodes to capacity
  else:
    g.nodes.add(node)
    return g.nodes.len

proc addEdge*[N,E](g: var Lgraph[N,E], A,B : int, edge : E) =
  g.edges[A*g.capacity + B] = E

proc findNode*[N,E](g: Lgraph[N,E], node : N): int =
  for i in 0..g.nodes.len-1:
    if g.nodes[i] == node:
      return i
  return -1

proc addEdge*[N,E](g: var Lgraph[N,E], A,B : N, edge : E) =
  let a = g.findNode(A)
  let b = g.findNode(B)
  g.addEdge(a,b,edge)

when isMainModule:
  var g : lgraph[string,float] = initLgraph(100)
  echo(g.addNode("a"))




