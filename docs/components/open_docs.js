function load_docs() {
	let [page, link] = getPageLocation();
	if (page)
		window.location.href = "docs.html"
}

// entries icon:  event_list

setTimeout(load_docs(), 0);