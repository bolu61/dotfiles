return {
	settings = {
		texlab = {
			build = {
				auxDirectory = "build",
				pdfDirectory = "build",
				logDirectory = "build",
				forwardSearchAfter = true,
				onSave = true,
			},
			forwardSearch = {
				executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
				args = { "-g", "-r", "%l", "%p", "%f" },
			},
			latexFormatter = "latexindent",
			diagnostics = {
				ignoredPatterns = { "Unused label", "Unused entry" },
			},
		},
	}
}
