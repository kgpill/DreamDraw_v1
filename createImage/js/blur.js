document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('imageButton').addEventListener('click', function () {
        document.getElementById('blurContainer').style.display = 'block';
        document.getElementById('popup').style.display = 'block';
    });

    document.getElementById('closeButton').addEventListener('click', function () {
        document.getElementById('blurContainer').style.display = 'none';
        document.getElementById('popup').style.display = 'none';
    });
});
