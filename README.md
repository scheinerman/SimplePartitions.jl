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
Partition of a set with 10 elements into 10 parts
```
The parameter to `Partition` may also be a list (one-dimensional array) or
a positive integer `n`, in which case a partition of the set {1,2,...,n} is
created.

### Construct from a set of sets

If `S` is a set of sets then `PartitionBuilder(S)` creates
a new partition whose parts are the sets in `S`. The
sets in `S` must be nonempty and pairwise disjoint.

## Functions

+ `num_elements(P)`: returns the number of elements in the ground
set of `P`.
+ `num_parts(P)`: returns the number of parts in `P`.
+ `parts(P)`: returns the set of the parts in this partition.
+ `ground_set(P)`: returns (a copy of) the ground set of `P`.
+ `in(a,P)`: test if `a` is in the ground set of `P`.
+ `merge_parts!(P,a,b)`: Modify `P` by merging the parts of `P` that
contain the elements `a` and `b`. This may also be called with a
list for the second argument: `merge_parts!(P,[a,b,...])`.
+ `in_same_part(P,a,b)`: returns `true` if `a` and `b` are in the same
part of `P`.
+ `find_part(P,a)`: returns the set of elements in `P` that are in
the same part as `a`.

## Operations

+ `join(P,Q)` returns the join of partitions `P` and `Q`. This can also
be invoked as `P+Q`.
+ `meet(P,Q)` returns the meet of the partitions. This can also be
invoked as `P*Q`.


## Relations

+ `P==Q` determines if `P` and `Q` are equal partitions.
+ `P<=Q` determines if `P` is a refinement of `Q`. That is, we return `true`
if each part of `P` is a subset of a part of `Q`. Note that `P` and `Q` must
have the same ground set or else an error is thrown. The variants
`P<Q`, `P>=Q`, and `P>Q` are available with the expected meanings. Calling
`refines(P,Q)` is the same as `P<=Q`.



## Examples
```julia
julia> A = Set(["alpha", "bravo", "charlie", "delta", "echo"])
{alpha,bravo,charlie,delta,echo}

julia> P = Partition(A)
Partition of a set with 5 elements into 5 parts

julia> merge_parts!(P,"alpha", "bravo")

julia> merge_parts!(P,"echo", "bravo")

julia> merge_parts!(P,"charlie", "delta")

julia> P
Partition of a set with 5 elements into 2 parts

julia> parts(P)
{{charlie,delta},{alpha,bravo,echo}}

julia> Q = Partition(A)
Partition of a set with 5 elements into 5 parts

julia> merge_parts!(Q,"alpha", "echo")

julia> merge_parts!(Q,"delta","alpha")

julia> parts(Q)
{{charlie},{bravo},{alpha,delta,echo}}

julia> parts(P+Q)
{{alpha,bravo,charlie,delta,echo}}

julia> parts(P*Q)
{{delta},{charlie},{bravo},{alpha,echo}}
```

<hr>
### To do list

+ Extend `in` so that `in(A,P)` is `true` if `A` is a
*part* of `P`.
+ Implement *element* addition/deletion.
Syntax `P+a` / `P-a`?
+ Implement *part* addition/deletion.
Syntax `P+A` / `P-A`?
