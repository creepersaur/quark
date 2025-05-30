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
    const start = main.scrollTop;
    const end = e.offsetTop - 50;

    const anim = main.animate([
        { scrollTop: start },
        { scrollTop: end },
    ], {
        duration: 500,
        easing: "ease-out",
        fill: "forwards",
    });

    // Animate manually using requestAnimationFrame
    const startTime = performance.now();

    function animateScroll(currentTime) {
        const elapsed = currentTime - startTime;
        const duration = 500;
        const progress = Math.min(elapsed / duration, 1);
        const ease = 1 - Math.pow(1 - progress, 3); // ease-out cubic

        const newPos = start + (end - start) * ease;
        main.scrollTop = newPos;
        main.scrollTop = newPos; // for Safari

        if (progress < 1) {
            requestAnimationFrame(animateScroll);
        }
    }

    requestAnimationFrame(animateScroll);
}
