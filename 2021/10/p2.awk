#!/usr/bin/awk -f

BEGIN { 
  FS = ""
}

{
  sz = 0
  for (i = 1; i <= NF; i++) {
    if ($i == "(")
      req[++sz] = ")"
    else if ($i == "[")
      req[++sz] = "]"
    else if ($i == "{")
      req[++sz] = "}"
    else if ($i == "<")
      req[++sz] = ">"
    else if ($i == req[sz])
      sz--
    else 
      next
  }
  
  score = 0
  for (; sz != 0; sz--) {
    score *= 5
    switch (req[sz]) {
    case ">":
      score++
    case "}":
      score++
    case "]":
      score++
    case ")":
      score++
    }
  }
  scores[++idx] = score
}

END { 
  n = asort(scores)
  print scores[int(n / 2) + 1]
}
