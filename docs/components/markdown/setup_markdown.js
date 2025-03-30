marked.setOptions({
	highlight: function (code, lang) {
		// Use Prism to highlight the code
		const validLang = Prism.languages[lang] ? lang : "clike"; // Default to 'clike' if language isn't found
		return Prism.highlight(code, Prism.languages[validLang], validLang);
	},
});

fetch("docs/hello.md")
	.then((response) => response.text())
	.then((data) => {
		document.getElementById("Main").innerHTML = marked.parse(data);
		Prism.highlightAll();
	})
	.catch((error) => console.error("Error loading topbar:", error));