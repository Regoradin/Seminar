<!doctype html>
<html>
    <head>
	<title>Select Seminar</title>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">

    </head>
    <body>
	<div id="root" >
	    <h1>Select a seminar to edit:</h1>
	    <form action="seminar" method="POST" v-for="result in results">
		<input type="hidden" name="sems_id" :value="result[0]">
		<input class="btn btn-primary" type="submit" name= "sem_name" :value="result[1]">
	    </form>
	    %end

	    <div class ="navFooter" >
		<form id="back" action="/teacher" method="GET">
		    <button type="button" class="btn" onclick="document.getElementById('back').submit();">Back</button>
		</form>
	    </div>
	</div>


	<script>
	 var app = new Vue
	 ({
	     el:'#root',
	     data:{
		 results:{{!results}}
	     },
	     delimeiters: ["<{","}>"]
	 });
	</script>
    </body>
</html>
