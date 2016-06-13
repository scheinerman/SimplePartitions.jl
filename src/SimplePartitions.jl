# nothing here
module SimplePartitions
using DataStructures

export Partition

type Partition{T}
  elements::Set{T}
  parts::DisjointSets{T}

  function Partition(A::Set{T})
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



end  # end of module
