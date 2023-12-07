return {
  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = "*",
    cond = require("mode").ide,
    event = "BufReadPre",
  }
}
