function dragover(wpevent) {
    wpevent.preventDefault();
}

function dragstart(wpevent) {
    wpevent.dataTransfer.effectAllowed = 'move';
    wpevent.dataTransfer.setData("Text", wpevent.target.id);
}

function dragend(wpevent) {
    wpevent.dataTransfer.clearData("Text");
}

function dragenter(wpevent){
    const categoryText = document.querySelector("#categoryText");
    categoryText.style.display = "none"
}


function drop(wpevent) {
    wpevent.preventDefault();
    var item = wpevent.dataTransfer.getData("Text");

    var draggedElement = document.getElementById(item);

    var nameValue = draggedElement.getAttribute("nameValue");

    if (wpevent.target.id === "categoryBar") {
        if (wpevent.target.childElementCount >= 2) {
            alert("하나의 감정만 선택해주세요!");
            return;
        }

        wpevent.target.appendChild(draggedElement);
    }

    if (wpevent.target.id === "emotionBox") { 
        wpevent.target.appendChild(draggedElement);
    }
    if (document.getElementById("categoryBar").childElementCount === 1) {
        document.getElementById("categoryText").style.display = "block";
    }

    console.log("Dropped nameValue:", nameValue);

    wpevent.stopPropagation();
}
