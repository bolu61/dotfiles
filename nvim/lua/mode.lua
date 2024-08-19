local fold = function (f, x, xs)
  for _, s in pairs(xs) do
    x = f(x, s)
  end
  return x
end

vim.g.ide = not fold(function (a, b) return a or b end, false, {
  vscode=vim.g.vscode,
})

return {
  ide=vim.g.ide
}

