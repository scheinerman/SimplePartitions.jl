using Memoize

export bell, Stirling1, Stirling2
export Stirling1matrix, Stirling2matrix

@memoize function bell(n)
  if n<0
    error("$n is negative")
  end
  if n==1 || n==0
    return BigInt(1)
  end
  N1 = BigInt(n)-1
  result = zero(BigInt)
  for k=0:n-1
    K = BigInt(k)
    result += binomial(N1,K) * bell(k)
  end
  return result
end
@doc """
`bell(n)` gives the `n`-th Bell number, that is,
the number of partitions of an `n`-element set
""" bell

@memoize function Stirling2(n::Int,k::Int)
  # special cases
  if k<0 || n<0
    error("Arguments must be nonnegative integers.")
  end

  if k>n
    return BigInt(0)
  end

  if n==0  # and by logic, k==0
    return BigInt(1)
  end

  if k==0
    return BigInt(0)
  end

  if n==k
    return BigInt(1)
  end
  # END OF SPECIAL CASES, invoke recursion

  return Stirling2(n-1,k-1) + Stirling2(n-1,k)*k
end
@doc """
`Stirling2(n,k)` gives the Stirling number of the second kind,
that is, the number of paritions of an `n`-set into `k`-parts."
""" Stirling2

@memoize function Stirling1(n::Int,k::Int)
  # special cases
  if k<0 || n<0
    error("Arguments must be nonnegative integers.")
  end

  if k>n
    return BigInt(0)
  end

  if n==0  # and, by logic, k==0
    return BigInt(1)
  end

  if k==0  # and, by logic, n>0
    return BigInt(0)
  end

  # end of special cases, invoke recursion

  return Stirling1(n-1,k-1) - (n-1)*Stirling1(n-1,k)
end
@doc """
`Stirling1(n,k)` gives the (signed) Stirling number
of the first kind, that is, the coefficient of `x^k`
in the poynomial `x(x-1)(x-2)...(x-n+1)`.
""" Stirling1

"""
Common code for the two Stirling matrix functions.
"""
function _matrix_maker(n::Int, f::Function)
  if n<0
    error("Argument must be nonnegative.")
  end

  M = zeros(BigInt,n+1,n+1)
  for i=0:n
    for j=0:n
      M[i+1,j+1] = f(i,j)
    end
  end
  return M
end

"""
`Stirling1matrix(n)` creates an `n+1`-by-`n+1` matrix
of Stirling numbers of the first kind (from `0,0` to `n,n`).
"""
function Stirling1matrix(n::Int)
  return _matrix_maker(n,Stirling1)
end


"""
`Stirling2matrix(n)` creates an `n+1`-by-`n+1` matrix
of Stirling numbers of the second kind (from `0,0` to `n,n`).
"""
function Stirling2matrix(n::Int)
  return _matrix_maker(n,Stirling2)
end
