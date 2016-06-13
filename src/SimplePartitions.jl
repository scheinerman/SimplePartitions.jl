# nothing here
module SimplePartitions
using DataStructures

export Partition

type Partition{T}
  elements::Set{T}
  parts::DisjointSets{T}

  function Partition{T}(A::Set{T})
    elts = deepcopy(A)
    pts  = DisjointSets{T}(A)
    P = new(elts,pts)
  end
end



end  # end of module
