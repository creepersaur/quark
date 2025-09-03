const main = document.getElementById("Main");

function LoadOverview() {
    const overview = document.getElementById("overview_content");
    const Headers = main.querySelectorAll("h1, h2");

    // CLEAR ALL THE CHILDREN
    overview.replaceChildren([]);

    Headers.forEach((e) => {
        let object = document.createElement("div");
        object.classList.add(e.nodeName);
        object.classList.add("Header");

        let hidden = e.querySelector("hidden");
        if (hidden) {
            object.innerHTML = hidden.innerHTML;
        } else {
            object.innerHTML = e.innerHTML;
        }

        // APPLY SCROLL ON CLICK
        object.addEventListener("click", () => {
            scrollToElement(e)
        });

        // ADD THE OBJECT TO THE OVERVIEW
        overview.appendChild(object);
    });
}

function scrollToElement(e) {
    const end = e.offsetTop - 50;
	main.scrollTop = end;
}
