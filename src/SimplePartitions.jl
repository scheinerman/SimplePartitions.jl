# nothing here
module SimplePartitions
using DataStructures

type Partition{T}
  elements::Set{T}
  parts::DisjointSets{T}

  function Partition{T}(A::Set{T})
    elements = deepcopy(A)
    parts = DisjointSets{T}(A)
    P = new(elements,parts)
  end
end



end  # end of module
