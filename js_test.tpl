<p id="words">Here be some words,</p>

<script>
function test(){
	document.getElementById("words").innerHTML += "new words";
}
</script>

<button type="button" onclick="test()">BUTTON</button>