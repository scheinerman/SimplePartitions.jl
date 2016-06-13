module SimplePartitions
using DataStructures

export Partition, set_element_type

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

end  # end of module
