using Memoize

export bell

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
