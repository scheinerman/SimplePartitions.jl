# SimplePartitions

Module for set partitions. This is a work in progress. We define a
`Partition` to be a wrapper around the `DisjointUnion` type defined
in the `DataStructures` module, but with a bit more functionality.


## Constructor

A new `Partition` is created by specifying the ground set. That is, if `A`
is a `Set{T}` (for some type `T`) or an `IntSet`, then `Partition(A)` creates
a new `Partition` whose ground set is `A` and the parts are singletons.
```julia
julia> using ShowSet
WARNING: Method definition show(Base.IO, Base.Set) ...
WARNING: Method definition show(Base.IO, Base.IntSet) ...

julia> using SimplePartitions

julia> A = Set(1:10)
{1,2,3,4,5,6,7,8,9,10}

julia> P = Partition(A)
Partition of {1,2,3,4,5,6,7,8,9,10} into 10 parts
```

## Functions

+ `num_elements(P)`: returns the number of elements in the ground
set of `P`.
+ `num_parts(P)`: returns the number of parts in `P`.
