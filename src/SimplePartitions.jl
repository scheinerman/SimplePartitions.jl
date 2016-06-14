module SimplePartitions
using DataStructures

import Base.show

export Partition, set_element_type, num_elements, num_parts, parts
export elements, has, merge_parts!

"""
`set_element_type(A)` gives the element type of a set `A`.
"""
function set_element_type{T}(A::Set{T})
  return T
end
set_element_type(B::IntSet) = Int


type Partition{T}
  elements::Set{T}
  parts::DisjointSets{T}

  function Partition{T}(A::Set{T})
    elts = deepcopy(A)
    pts  = DisjointSets{T}(A)
    new(elts,pts)
  end

  function Partition(B::IntSet)
    elts = Set(B)
    pts  = DisjointSets{Int}(elts)
    new(elts,pts)
  end
end


"""
A `Partition` is a set of nonempty, pairwise disjoint sets.
A new `Partition` is created by specifying the ground set `A`
and calling `Partition(A)`. The set `A` may be either a `Set{T}`
for some type `T` or an `IntSet`.

The datatype `Partition` is, essentially, a wrapper around the
`DataStructures.DisjointSets` type.
"""
function Partition(A::Set)
  T = set_element_type(A)
  return Partition{T}(A)
end
Partition(B::IntSet) = Partition{Int}(B)

function show(io::IO, P::Partition)
  print(io, "Partition of $(P.elements) into $(num_parts(P)) parts")
end

"""
`has(P,a)` checks if `a` is in the ground set of `P`.
"""
function has{T}(P::Partition{T}, a::T)
  return in(a,P.elements)
end

"""
`merge_parts!(P,a,b)` updates `P` by merging the parts
that contain elements `a` and `b`.
"""
function merge_parts!{T}(P::Partition{T},a::T,b::T)
  if !has(P,a) || !has(P,b)
    error("One or both of these elements are not in the partition.")
  end
  union!(P.parts,a,b)
  nothing
end


"""
`num_parts(P)` gives the number of parts in the partition `P`.
"""
num_parts(P::Partition) = num_groups(P.parts)

"""
`num_elements(P)` gives the number of elements in the ground
set of the partition `P`. This equals the sum of the sizes of the
parts.
"""
num_elements(P::Partition) = length(P.elements)

"""
`elements(P)` returns (a copy of) the ground set of the
partition `P`.
"""
elements(P::Partition) = deepcopy(P.elements)

"""
`parts(P)` returns a set containing the parts of the partition `P`.
That is, we return a set of sets.
"""
function parts{T}(P::Partition{T})
  n = num_parts(P)
  GS = P.elements

  # Find the indices of the roots of the parts
  root_set = Set{Int}()
  for item in GS
    r = find_root(P.parts,item)
    push!(root_set,r)
  end
  roots = collect(root_set)  # make it an array

  # Create a mapping from root numbers to [1:n]
  rootmap = Dict{Int,Int}()
  for k=1:n
    rootmap[roots[k]] = k
  end

  # Create an array of sets to hold the parts
  plist = Array(Set{T},n)
  for k=1:n
    plist[k] = Set{T}()  # make sure they're empty sets
  end

  # For each element in the ground set, look up its root
  # in order to place it in its appropriate set.
  for item in GS
    idx = rootmap[find_root(P.parts,item)]
    push!(plist[idx], item)
  end

  # now take those parts and pack them into a set
  S = Set{Set{T}}()
  for item in plist
    push!(S,item)
  end

  return S
end



end  # end of module
