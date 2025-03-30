const items = document.querySelectorAll(".FoldItem")

items.forEach((i) => {
	i.addEventListener("click", () => {
		items.forEach((e) => e.removeAttribute("active"))
		i.setAttribute("active", 1)
	})
})