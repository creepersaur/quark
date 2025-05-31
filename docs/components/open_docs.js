function load_docs() {
	let [page, link] = getPageLocation();
	if (page)
		window.location.href = "docs.html"
}

setTimeout(load_docs(), 0);