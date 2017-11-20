export all_partitions
"""
`all_partitions(A::Set)` creates a `Set` containing all possible
partitions of the set `A`.

`all_partitions(n::Int)` creates the `Set` of all paritions of
the set `{1,2,...,n}`.
"""
function all_partitions(A::Set{T}) where T
    if length(A) < 2
        P = Partition(A)
        return Set([P])
    end
    # Set aside one element of A and recurse
    x = first(A)
    B = deepcopy(A)
    delete!(B,x)

    PB = all_partitions(B)
    PA = Set{Partition{T}}()  # place to hold partitions we create

    for P in PB
        # case 1: include x as a singleton
        P_parts = parts(P)
        push!(P_parts, Set([x]))
        Q = PartitionBuilder(P_parts)
        push!(PA,Q)

        # case 2: insert x into existing parts
        parts_list = collect(parts(P))
        np = length(parts_list)
        for k=1:np
            push!(parts_list[k],x)  # insert x into k'th part
            Q = PartitionBuilder(Set(parts_list)) # build the partition
            push!(PA,Q)
            delete!(parts_list[k],x) # take it back out
        end

    end
    return PA
end

function all_partitions(n::Int)
    if n < 0
        error("argument must be a nonnegative integer")
    end
    A = Set{Int}(collect(1:n))
    return all_partitions(A)
end
