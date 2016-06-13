# SimplePartitions

Module for set partitions. This is a work in progress. We define a
`Partition` to be a wrapper around the `DisjointUnion` type defined
in the `DataStructures` module, but with a bit more functionality.


## Constructor

A new `Partition` is created by specifying the ground set. That is, if `A`
is a `Set{T}` (for some type `T`) or an `IntSet`, then `Partition(A)` creates
a new `Partition` whose ground set is `A` and the parts are singletons.
