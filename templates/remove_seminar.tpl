<!doctype html>
<html>
    <head>
	<title>Remove Seminar</title>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">
    </head>
    <body>
	<div id="root">
	    <div v-for="seminar in seminars">
		<span><{seminar[1]}></span>
		<button class="btn btn-primary" v-on:click="RemoveSeminar(seminar[0])">Remove</button>
	    </div>

	    <div class="navFooter" >
		<form action="remove"  method="POST">
		    <input type="hidden" v-for= "seminar in removed_sems" name="removed" :value="seminar" >
		    <input class="btn" type="submit" name="save" value="Back">
		</form>
	    </div>
	</div>
	<script>
	 var app = new Vue
	 ({
	     el:'#root',
	     data:{
		 seminars:{{!seminars}},
		 removed_sems:[]
	     },
	     delimiters: ["<{", "}>"],
	     methods:{
		 RemoveSeminar:function(id){
		     for(i=0; i < this.seminars.length; i++){
			 if(this.seminars[i][0] === id){
			     this.seminars.splice(i, 1);
			 }
		     };
		     this.removed_sems.push(id);
		 }
	     }
	 });
	 
	</script>
    </body>
</html>
