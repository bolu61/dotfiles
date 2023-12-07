local fold = function (f, x, xs)
  for _, s in pairs(xs) do
    x = f(x, s)
  end
  return x
end

return {
  ide = not fold(function (a, b) return a or b end, false, {
    vscode=vim.g.vscode,
  })
}

