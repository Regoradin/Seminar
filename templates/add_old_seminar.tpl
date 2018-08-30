<!doctype html>
<html>
    <head>
	
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
	    <form action="add_old" method="POST" v-for="seminar in old_seminars" >
		<input type="hidden" name="sem_id" :value="seminar[0]" >
		<h3><{seminar[1]}></h3>
		<div><{seminar[2]}></div>
		<select name="session" required>
		    <option selected disabled hidden>Select Session</option>
		    <option value="1" >First Session</option>
		    <option value="2" >Second Session</option>
		    <option value="3" >Double Session</option>
		</select>
		<select name="room_id" required>
		    <option v-for="room in rooms" :value="room[0]"><{room[1]}></option>
		</select>
		<input type="submit" value="Save">
	    </form>

	    <form action="/teacher" method="GET">
		<input type="submit" value="Back">
	    </form>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
	<script src="/js/helpers.js"></script>
	<script>
	 var app = new Vue
	 ({
	     el:'#root',
	     data:{
		 old_seminars:{{!old_seminars}},
		 added_seminars:[],
		 rooms:{{!rooms}}
	     },
	     delimiters: ["<{", "}>"],
	     methods:{
		 AddSeminar:function(seminar){
		     if(this.added_seminars.indexOf(seminar[0]) === -1){
			 this.added_seminars.push(seminar[0]);
			 RemoveElem(this.old_seminars, seminar);
		     }
		 }
	     }
	 });
	</script>
    </body>
</html>
